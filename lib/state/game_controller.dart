import 'dart:math';

import 'package:flutter/foundation.dart';

import '../data/bite_cards_data.dart';
import '../data/malus_cards_data.dart';
import '../models/bite_card.dart';
import '../models/bonus_effect.dart';
import '../models/malus_card.dart';
import '../models/player.dart';

enum TurnPhase {
  chooseSize,
  flipping,
  resolveMalus,
  revealBonus,
  showCard,
  turnEnd,
}

class GameController extends ChangeNotifier {
  final List<Player> players = [];
  int currentPlayerIndex = 0;
  final _random = Random();

  TurnPhase phase = TurnPhase.chooseSize;

  BiteSize? chosenSize;
  bool? coin1Heads;
  bool? coin2Heads;
  BiteCard? drawnCard;
  MalusCard? drawnMalus;
  BonusEffect? awardedBonus;
  bool sipsCancelled = false;
  Player? doubleSipsTarget;
  bool doubleSipsOnSuccessActive = false;
  bool skipChallengeActive = false;
  Player? forcedPartner;
  bool malusAvoidedByImmunity = false;

  /// Phase à appliquer une fois que le joueur a validé le résumé du lancer.
  TurnPhase? _pendingPhase;
  bool get flipResultReady => _pendingPhase != null;

  /// Joueur qui doit réellement résoudre le tour (peut différer de
  /// [currentPlayer] via les bonus "refile ta carte" / "remplaçant forcé").
  Player? _actingOverride;
  Player get actingPlayer => _actingOverride ?? currentPlayer;

  Player get currentPlayer => players[currentPlayerIndex];

  void addPlayer(String name) {
    players.add(Player(name));
    notifyListeners();
  }

  void removePlayer(int index) {
    players.removeAt(index);
    notifyListeners();
  }

  void startGame() {
    currentPlayerIndex = 0;
    _resetTurnState();
    notifyListeners();
  }

  void chooseBiteSize(BiteSize size) {
    chosenSize = size;
    phase = TurnPhase.flipping;
    notifyListeners();
  }

  void flipCoinOne() {
    coin1Heads = _random.nextBool();
    notifyListeners();
  }

  void flipCoinTwo() {
    coin2Heads = _random.nextBool();
    _resolveOutcome();
    notifyListeners();
  }

  /// Applique la phase calculée par [_resolveOutcome] une fois le résumé du
  /// lancer acquitté par le joueur.
  void confirmFlipResult() {
    if (_pendingPhase == null) return;
    phase = _pendingPhase!;
    _pendingPhase = null;
    notifyListeners();
  }

  /// Résumé textuel du lancer, affiché avant de révéler la suite du tour.
  String get flipOutcomeSummary {
    final size = chosenSize!;
    if (coin1Heads! && coin2Heads!) {
      return "2 Pile ! Tu pioches une ${size.label.toLowerCase()} + une capote saine.";
    } else if (!coin1Heads! && !coin2Heads!) {
      return malusAvoidedByImmunity
          ? "2 Face ! Ton immunité te protège : pas de capote trouée."
          : "2 Face ! Tu pioches une ${size.opposite.label.toLowerCase()} + une capote trouée.";
    }
    return "Pile et Face : tu pioches une ${size.label.toLowerCase()}, rien d'autre.";
  }

  void _resolveOutcome() {
    final size = chosenSize!;
    malusAvoidedByImmunity = false;
    if (coin1Heads! && coin2Heads!) {
      // 2 pile : la bite choisie + une capote saine (bonus)
      drawnCard = _drawBite(size);
      awardedBonus = BonusEffect.values[_random.nextInt(BonusEffect.values.length)];
      _pendingPhase = TurnPhase.revealBonus;
    } else if (!coin1Heads! && !coin2Heads!) {
      // 2 face : la bite opposée + une capote trouée (malus)
      drawnCard = _drawBite(size.opposite);
      if (actingPlayer.immuneToNextMalus) {
        actingPlayer.immuneToNextMalus = false;
        malusAvoidedByImmunity = true;
        _pendingPhase = TurnPhase.showCard;
      } else {
        drawnMalus = _drawMalus();
        _pendingPhase = TurnPhase.resolveMalus;
      }
    } else {
      // 1 pile, 1 face : juste la bite choisie, rien d'autre
      drawnCard = _drawBite(size);
      _pendingPhase = TurnPhase.showCard;
    }
  }


  BiteCard _drawBite(BiteSize size) {
    final pool = size == BiteSize.grosse ? grosseBiteCards : petiteBiteCards;
    return pool[_random.nextInt(pool.length)];
  }

  MalusCard _drawMalus() => malusCards[_random.nextInt(malusCards.length)];

  void malusResolved() {
    final malus = drawnMalus;
    if (malus != null && malus.discardsBonus && actingPlayer.bonusInventory.isNotEmpty) {
      actingPlayer.bonusInventory.removeAt(_random.nextInt(actingPlayer.bonusInventory.length));
    }
    phase = TurnPhase.showCard;
    notifyListeners();
  }

  void bonusAcknowledged() {
    actingPlayer.bonusInventory.add(awardedBonus!);
    phase = TurnPhase.showCard;
    notifyListeners();
  }

  void actionDone(Map<Player, int> distribution) {
    final multiplier = doubleSipsOnSuccessActive ? 2 : 1;
    distribution.forEach((player, sips) => player.totalSipsDrunk += sips * multiplier);
    phase = TurnPhase.turnEnd;
    notifyListeners();
  }

  void actionDoneCulSec(Player recipient) {
    recipient.totalCulSecs += 1;
    phase = TurnPhase.turnEnd;
    notifyListeners();
  }

  void actionRefused() {
    if (!sipsCancelled) {
      final card = drawnCard!;
      if (card.culSec) {
        actingPlayer.totalCulSecs += 1;
      } else {
        actingPlayer.totalSipsDrunk += card.sips!;
      }
    }
    phase = TurnPhase.turnEnd;
    notifyListeners();
  }

  void endTurn() {
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
    _resetTurnState();
    notifyListeners();
  }

  void _resetTurnState() {
    phase = TurnPhase.chooseSize;
    chosenSize = null;
    coin1Heads = null;
    coin2Heads = null;
    drawnCard = null;
    drawnMalus = null;
    awardedBonus = null;
    sipsCancelled = false;
    doubleSipsTarget = null;
    doubleSipsOnSuccessActive = false;
    skipChallengeActive = false;
    forcedPartner = null;
    malusAvoidedByImmunity = false;
    _pendingPhase = null;
    _actingOverride = null;
  }

  /// Un effet n'a de sens que dans certaines phases du tour en cours.
  bool isBonusUsableNow(BonusEffect effect) {
    switch (effect) {
      case BonusEffect.cancelOwnSips:
      case BonusEffect.passActionToSomeone:
      case BonusEffect.swapBiteSize:
      case BonusEffect.doubleSipsToOpponent:
      case BonusEffect.doubleSipsOnSuccess:
      case BonusEffect.skipChallengeKeepSips:
      case BonusEffect.redrawBite:
      case BonusEffect.forceJoinChallenge:
        return phase == TurnPhase.showCard;
      case BonusEffect.forceSomeoneElseTurn:
      case BonusEffect.swapChallengeWithNext:
        return phase == TurnPhase.chooseSize;
      case BonusEffect.immunityNextMalus:
        return true;
    }
  }

  /// Applique un effet bonus depuis l'inventaire du joueur donné.
  void useBonus(Player owner, BonusEffect effect, {Player? target}) {
    if (!isBonusUsableNow(effect)) return;
    if (!owner.bonusInventory.remove(effect)) return;

    switch (effect) {
      case BonusEffect.cancelOwnSips:
        sipsCancelled = true;
        break;
      case BonusEffect.passActionToSomeone:
        _actingOverride = target;
        break;
      case BonusEffect.forceSomeoneElseTurn:
        _actingOverride = target;
        break;
      case BonusEffect.immunityNextMalus:
        owner.immuneToNextMalus = true;
        break;
      case BonusEffect.swapBiteSize:
        if (drawnCard != null) {
          drawnCard = _drawBite(drawnCard!.size.opposite);
        }
        break;
      case BonusEffect.doubleSipsToOpponent:
        doubleSipsTarget = target;
        break;
      case BonusEffect.doubleSipsOnSuccess:
        doubleSipsOnSuccessActive = true;
        break;
      case BonusEffect.swapChallengeWithNext:
        _actingOverride = players[(currentPlayerIndex + 1) % players.length];
        break;
      case BonusEffect.skipChallengeKeepSips:
        skipChallengeActive = true;
        break;
      case BonusEffect.redrawBite:
        if (drawnCard != null) {
          drawnCard = _drawBite(drawnCard!.size);
        }
        break;
      case BonusEffect.forceJoinChallenge:
        forcedPartner = target;
        break;
    }
    notifyListeners();
  }
}
