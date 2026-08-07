import 'package:flutter/material.dart';

import '../state/game_controller.dart';

class CoinFlipView extends StatefulWidget {
  const CoinFlipView({super.key, required this.game});

  final GameController game;

  @override
  State<CoinFlipView> createState() => _CoinFlipViewState();
}

class _CoinFlipViewState extends State<CoinFlipView> with TickerProviderStateMixin {
  late final AnimationController _controller1 = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  late final AnimationController _controller2 = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  bool _spinning1 = false;
  bool _spinning2 = false;

  Future<void> _flipFirst() async {
    setState(() => _spinning1 = true);
    await _controller1.forward(from: 0);
    widget.game.flipCoinOne();
    if (!mounted) return;
    setState(() => _spinning1 = false);
  }

  Future<void> _flipSecond() async {
    setState(() => _spinning2 = true);
    await _controller2.forward(from: 0);
    widget.game.flipCoinTwo();
    if (!mounted) return;
    setState(() => _spinning2 = false);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    final coin1Done = game.coin1Heads != null;
    final coin2Done = game.coin2Heads != null;
    final summaryReady = game.flipResultReady;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${game.currentPlayer.name} lance la pièce, deux fois",
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Coin(controller: _controller1, spinning: _spinning1, heads: game.coin1Heads),
            const SizedBox(width: 32),
            _Coin(controller: _controller2, spinning: _spinning2, heads: game.coin2Heads),
          ],
        ),
        const SizedBox(height: 40),
        if (summaryReady) ...[
          Card(
            color: Colors.deepPurple.withValues(alpha: 0.35),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                game.flipOutcomeSummary,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: game.confirmFlipResult,
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Continuer"),
          ),
        ] else if (!coin1Done) ...[
          FilledButton.icon(
            onPressed: _spinning1 ? null : _flipFirst,
            icon: const Icon(Icons.monetization_on),
            label: const Text("Lancer la 1ère pièce"),
          ),
        ] else if (!coin2Done) ...[
          FilledButton.icon(
            onPressed: _spinning2 ? null : _flipSecond,
            icon: const Icon(Icons.monetization_on),
            label: const Text("Lancer la 2e pièce"),
          ),
        ],
      ],
    );
  }
}

class _Coin extends StatelessWidget {
  const _Coin({required this.controller, required this.spinning, required this.heads});

  final AnimationController controller;
  final bool spinning;
  final bool? heads;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final angle = spinning ? controller.value * 4 * 3.14159 : 0.0;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            ..rotateY(angle),
          child: child,
        );
      },
      child: _CoinFace(heads: spinning ? null : heads),
    );
  }
}

/// Une pièce avec un vrai côté "PILE" et un vrai côté "FACE".
class _CoinFace extends StatelessWidget {
  const _CoinFace({required this.heads});

  /// `null` tant que le résultat n'est pas connu (pièce en l'air).
  final bool? heads;

  @override
  Widget build(BuildContext context) {
    final label = heads == null ? "?" : (heads! ? "PILE" : "FACE");
    final colors = heads == null
        ? [Colors.grey.shade600, Colors.grey.shade800]
        : (heads!
            ? [Colors.amber.shade300, Colors.amber.shade700]
            : [Colors.blueGrey.shade200, Colors.blueGrey.shade500]);

    return AnimatedScale(
      scale: heads != null ? 1.08 : 1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.elasticOut,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: colors),
          border: Border.all(color: Colors.white24, width: 3),
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4)),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.black87),
        ),
      ),
    );
  }
}

