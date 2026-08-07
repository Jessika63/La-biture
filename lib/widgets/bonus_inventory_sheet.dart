import 'package:flutter/material.dart';

import '../models/bonus_effect.dart';
import '../models/player.dart';
import '../state/game_controller.dart';

/// Sélectionne un joueur cible parmi tous les joueurs sauf [exclude].
Future<Player?> pickTargetPlayer(
  BuildContext context, {
  required List<Player> players,
  Player? exclude,
}) {
  final candidates = players.where((p) => p != exclude).toList();
  return showDialog<Player>(
    context: context,
    builder: (context) => SimpleDialog(
      title: const Text("Choisis un joueur"),
      children: candidates
          .map((p) => SimpleDialogOption(
                onPressed: () => Navigator.of(context).pop(p),
                child: Text(p.name),
              ))
          .toList(),
    ),
  );
}

class BonusInventorySheet extends StatelessWidget {
  const BonusInventorySheet({super.key, required this.game, required this.player});

  final GameController game;
  final Player player;

  @override
  Widget build(BuildContext context) {
    final bonuses = List<BonusEffect>.from(player.bonusInventory);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          Text("Capotes saines de ${player.name}", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (bonuses.isEmpty) const Text("Tu n'as pas encore de bonus."),
          for (final effect in bonuses) _BonusTile(game: game, owner: player, effect: effect),
        ],
      ),
    );
  }
}

class _BonusTile extends StatelessWidget {
  const _BonusTile({required this.game, required this.owner, required this.effect});

  final GameController game;
  final Player owner;
  final BonusEffect effect;

  bool get _needsTarget =>
      effect == BonusEffect.passActionToSomeone ||
      effect == BonusEffect.doubleSipsToOpponent ||
      effect == BonusEffect.forceSomeoneElseTurn ||
      effect == BonusEffect.forceJoinChallenge;

  Future<void> _use(BuildContext context) async {
    Player? target;
    if (_needsTarget) {
      target = await pickTargetPlayer(context, players: game.players, exclude: owner);
      if (target == null) return;
    }
    game.useBonus(owner, effect, target: target);
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final usable = game.isBonusUsableNow(effect);
    return ListTile(
      leading: const Icon(Icons.shield, color: Colors.greenAccent),
      title: Text(effect.title),
      subtitle: Text(effect.description),
      trailing: FilledButton(
        onPressed: usable ? () => _use(context) : null,
        child: const Text("Utiliser"),
      ),
    );
  }
}
