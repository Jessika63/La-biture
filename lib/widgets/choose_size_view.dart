import 'package:flutter/material.dart';

import '../models/bite_card.dart';
import '../state/game_controller.dart';

class ChooseSizeView extends StatelessWidget {
  const ChooseSizeView({super.key, required this.game});

  final GameController game;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${game.currentPlayer.name}, choisis ta bite",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _SizeButton(
              label: "Grosse bite",
              icon: Icons.local_fire_department,
              colors: const [Colors.pink, Colors.deepPurple],
              onTap: () => game.chooseBiteSize(BiteSize.grosse),
            ),
            _SizeButton(
              label: "Petite bite",
              icon: Icons.eco,
              colors: const [Colors.orange, Colors.deepOrange],
              onTap: () => game.chooseBiteSize(BiteSize.petite),
            ),
          ],
        ),
      ],
    );
  }
}

class _SizeButton extends StatelessWidget {
  const _SizeButton({
    required this.label,
    required this.icon,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final List<Color> colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 6))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

