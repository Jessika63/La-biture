import 'package:flutter/material.dart';

import '../models/bonus_effect.dart';
import '../state/game_controller.dart';

class BonusRevealView extends StatelessWidget {
  const BonusRevealView({super.key, required this.game});

  final GameController game;

  @override
  Widget build(BuildContext context) {
    final bonus = game.awardedBonus!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.verified, size: 64, color: Colors.greenAccent),
        const SizedBox(height: 16),
        Text(
          "Capote saine : bonus pour ${game.actingPlayer.name} !",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Card(
          color: Colors.green.withValues(alpha: 0.15),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(bonus.title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  bonus.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "À garder, utilisable à n'importe quel moment de la partie.",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60),
        ),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: game.bonusAcknowledged,
          child: const Text("Je le garde"),
        ),
      ],
    );
  }
}
