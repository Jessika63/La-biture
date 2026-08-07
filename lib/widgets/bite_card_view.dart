import 'package:flutter/material.dart';

import '../models/bite_card.dart';
import '../models/player.dart';
import '../state/game_controller.dart';
import 'bite_shape_card.dart';
import 'bonus_inventory_sheet.dart';
import 'distribute_sips_sheet.dart';

class BiteCardView extends StatelessWidget {
  const BiteCardView({super.key, required this.game});

  final GameController game;

  Future<void> _doAction(BuildContext context) async {
    final card = game.drawnCard!;
    if (card.culSec) {
      final recipient = await pickTargetPlayer(
        context,
        players: game.players,
        exclude: game.actingPlayer,
      );
      if (recipient == null) return;
      game.actionDoneCulSec(recipient);
      return;
    }

    final result = await showModalBottomSheet<Map<dynamic, int>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DistributeSipsSheet(card: card, game: game),
    );
    if (result != null) {
      game.actionDone(result.cast<Player, int>());
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = game.drawnCard!;
    final colors = card.size == BiteSize.grosse
        ? [Colors.pink.shade300, Colors.deepPurple.shade700]
        : [Colors.orange.shade200, Colors.deepOrange.shade600];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          card.size.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 12),
        BiteShapeCard(
          colors: colors,
          width: 260,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                card.action,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                card.sipsLabel,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
        ),
        if (game.forcedPartner != null) ...[
          const SizedBox(height: 12),
          Text(
            "${game.forcedPartner!.name} doit faire le défi avec toi !",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.orangeAccent),
            textAlign: TextAlign.center,
          ),
        ],
        if (game.skipChallengeActive) ...[
          const SizedBox(height: 12),
          Text(
            "Défi esquivé : tu peux distribuer les cdr sans le faire.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.orangeAccent),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton.icon(
              onPressed: () => _doAction(context),
              icon: const Icon(Icons.check),
              label: const Text("Action faite"),
            ),
            OutlinedButton.icon(
              onPressed: game.actionRefused,
              icon: const Icon(Icons.close),
              label: const Text("Je refuse, je bois"),
            ),
          ],
        ),
      ],
    );
  }
}

