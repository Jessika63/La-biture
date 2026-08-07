import 'package:flutter/material.dart';

import '../models/bite_card.dart';
import '../models/player.dart';
import '../state/game_controller.dart';

/// Répartit les cdr d'une carte (hors cul sec) entre les autres joueurs.
/// Retourne la map finale via [Navigator.pop] quand la somme correspond au total.
class DistributeSipsSheet extends StatefulWidget {
  const DistributeSipsSheet({super.key, required this.card, required this.game});

  final BiteCard card;
  final GameController game;

  @override
  State<DistributeSipsSheet> createState() => _DistributeSipsSheetState();
}

class _DistributeSipsSheetState extends State<DistributeSipsSheet> {
  late final List<Player> _others = widget.game.players
      .where((p) => p != widget.game.actingPlayer)
      .toList();
  late final Map<Player, int> _allocation = {for (final p in _others) p: 0};

  int get _allocated => _allocation.values.fold(0, (a, b) => a + b);
  int get _remaining => widget.card.sips! - _allocated;

  void _adjust(Player player, int delta) {
    final next = _allocation[player]! + delta;
    if (next < 0) return;
    if (delta > 0 && _remaining <= 0) return;
    setState(() => _allocation[player] = next);
  }

  @override
  Widget build(BuildContext context) {
    final doubleTarget = widget.game.doubleSipsTarget;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Distribue ${widget.card.sips} cdr",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("Restant : $_remaining"),
          const SizedBox(height: 12),
          ..._others.map((player) {
            final isDoubled = doubleTarget == player;
            final effective = _allocation[player]! * (isDoubled ? 2 : 1);
            return ListTile(
              leading: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => _adjust(player, -1),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => _adjust(player, 1),
              ),
              subtitle: isDoubled
                  ? const Text("Bonus : doublé !", style: TextStyle(color: Colors.greenAccent))
                  : null,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(player.name),
                  Text("$effective cdr"),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _remaining == 0
                ? () {
                    final result = {
                      for (final entry in _allocation.entries)
                        entry.key: entry.value * (doubleTarget == entry.key ? 2 : 1),
                    };
                    Navigator.of(context).pop(result);
                  }
                : null,
            child: const Text("Valider"),
          ),
        ],
      ),
    );
  }
}
