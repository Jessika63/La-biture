import 'package:flutter/material.dart';

import '../state/game_controller.dart';

class MalusView extends StatelessWidget {
  const MalusView({super.key, required this.game});

  final GameController game;

  @override
  Widget build(BuildContext context) {
    final malus = game.drawnMalus!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.dangerous, size: 64, color: Colors.redAccent),
        const SizedBox(height: 16),
        Text(
          "Capote trouée : malus pour ${game.actingPlayer.name}",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Card(
          color: Colors.red.withValues(alpha: 0.15),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  malus.action,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                if (malus.sips != null) ...[
                  const SizedBox(height: 12),
                  Text("${malus.sips} cdr", style: Theme.of(context).textTheme.titleMedium),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "À faire avant de découvrir ta bite.",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60),
        ),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: game.malusResolved,
          child: const Text("C'est fait"),
        ),
      ],
    );
  }
}
