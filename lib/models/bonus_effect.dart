/// Effets concrets déclenchés par une capote saine (bonus).
/// Un joueur peut en garder plusieurs et les utiliser quand il veut.
enum BonusEffect {
  cancelOwnSips,
  passActionToSomeone,
  doubleSipsToOpponent,
  immunityNextMalus,
  swapBiteSize,
  forceSomeoneElseTurn,
  doubleSipsOnSuccess,
  swapChallengeWithNext,
  skipChallengeKeepSips,
  redrawBite,
  forceJoinChallenge,
}

extension BonusEffectInfo on BonusEffect {
  String get title {
    switch (this) {
      case BonusEffect.cancelOwnSips:
        return "Cdr annulés";
      case BonusEffect.passActionToSomeone:
        return "Refile ta carte";
      case BonusEffect.doubleSipsToOpponent:
        return "Double punition";
      case BonusEffect.immunityNextMalus:
        return "Immunité malus";
      case BonusEffect.swapBiteSize:
        return "Échange de bite";
      case BonusEffect.forceSomeoneElseTurn:
        return "Remplaçant forcé";
      case BonusEffect.doubleSipsOnSuccess:
        return "Mise doublée";
      case BonusEffect.swapChallengeWithNext:
        return "Échange de défi";
      case BonusEffect.skipChallengeKeepSips:
        return "Défi esquivé";
      case BonusEffect.redrawBite:
        return "Nouvelle pioche";
      case BonusEffect.forceJoinChallenge:
        return "Duo forcé";
    }
  }

  String get description {
    switch (this) {
      case BonusEffect.cancelOwnSips:
        return "Annule les cdr que tu devais boire.";
      case BonusEffect.passActionToSomeone:
        return "Refile ta carte et son action à quelqu'un d'autre.";
      case BonusEffect.doubleSipsToOpponent:
        return "Double les cdr donnés à un adversaire de ton choix.";
      case BonusEffect.immunityNextMalus:
        return "Ignore le prochain malus (capote trouée) que tu tires.";
      case BonusEffect.swapBiteSize:
        return "Échange ta bite tirée (grosse ↔ petite) avant de lire l'action.";
      case BonusEffect.forceSomeoneElseTurn:
        return "Force quelqu'un d'autre à rejouer un tour à ta place.";
      case BonusEffect.doubleSipsOnSuccess:
        return "Si tu réussis ton défi, double le nombre de cdr infligés.";
      case BonusEffect.swapChallengeWithNext:
        return "Échange ton défi avec le joueur suivant.";
      case BonusEffect.skipChallengeKeepSips:
        return "Passe ton défi sans le faire, mais distribue quand même les cdr.";
      case BonusEffect.redrawBite:
        return "Remets ta bite dans la pile, mélange, et repioche une nouvelle carte.";
      case BonusEffect.forceJoinChallenge:
        return "Force un autre joueur à faire le défi avec toi, sans bonus pour lui.";
    }
  }

  /// Un effet ne peut être utilisé que dans certaines phases du tour.
  bool get usableDuringOwnTurnAnytime => this == BonusEffect.immunityNextMalus;
}
