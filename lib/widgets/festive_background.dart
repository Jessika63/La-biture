import 'package:flutter/material.dart';

/// Fond dégradé festif avec quelques touches décoratives, utilisé en toile
/// de fond des écrans du jeu.
class FestiveBackground extends StatelessWidget {
  const FestiveBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2D0B4E), Color(0xFF6A1B9A), Color(0xFFAD1457)],
            ),
          ),
        ),
        const Positioned(top: -40, left: -30, child: _Blob(color: Color(0x33FFD54F), size: 160)),
        const Positioned(bottom: -60, right: -40, child: _Blob(color: Color(0x33FF4081), size: 220)),
        const Positioned(top: 140, right: -40, child: _Blob(color: Color(0x22FFFFFF), size: 110)),
        child,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
