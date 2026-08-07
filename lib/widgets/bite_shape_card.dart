import 'package:flutter/material.dart';

/// Petit dessin de bite (déco, dessiné avec un CustomPainter) au-dessus d'une
/// carte basique et sûre pour le texte (jamais de débordement).
class BiteShapeCard extends StatelessWidget {
  const BiteShapeCard({
    super.key,
    required this.colors,
    required this.child,
    this.width = 260,
  });

  final List<Color> colors;
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: width * 0.6,
          height: width * 0.78,
          child: CustomPaint(painter: _BiteDoodlePainter(colors)),
        ),
        const SizedBox(height: 16),
        Container(
          width: width,
          constraints: const BoxConstraints(minHeight: 140),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.last, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black45, blurRadius: 12, offset: Offset(0, 6)),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}

/// Dessine une bite stylisée : dôme, fût et bourses.
class _BiteDoodlePainter extends CustomPainter {
  _BiteDoodlePainter(this.colors);

  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final shaftWidth = w * 0.5;
    final left = (w - shaftWidth) / 2;
    final right = left + shaftWidth;
    final domeRadius = shaftWidth / 2;
    final domeCenterY = domeRadius + h * 0.04;
    final shaftBottom = h * 0.72;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: colors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final path = Path()
      ..moveTo(left, domeCenterY)
      ..arcTo(
        Rect.fromCircle(center: Offset(w / 2, domeCenterY), radius: domeRadius),
        3.14159,
        3.14159,
        false,
      )
      ..lineTo(right, shaftBottom)
      ..quadraticBezierTo(right, shaftBottom + 18, right - 18, shaftBottom + 18)
      ..lineTo(left + 18, shaftBottom + 18)
      ..quadraticBezierTo(left, shaftBottom + 18, left, shaftBottom)
      ..close();
    canvas.drawPath(path, fillPaint);

    final ridgePaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawLine(
      Offset(left + 6, domeCenterY + domeRadius * 0.55),
      Offset(right - 6, domeCenterY + domeRadius * 0.55),
      ridgePaint,
    );

    final ballPaint = Paint()..shader = fillPaint.shader;
    final ballRadius = shaftWidth * 0.34;
    final ballY = shaftBottom + 18;
    canvas.drawCircle(Offset(w / 2 - shaftWidth * 0.38, ballY), ballRadius, ballPaint);
    canvas.drawCircle(Offset(w / 2 + shaftWidth * 0.38, ballY), ballRadius, ballPaint);
  }

  @override
  bool shouldRepaint(covariant _BiteDoodlePainter oldDelegate) => oldDelegate.colors != colors;
}
