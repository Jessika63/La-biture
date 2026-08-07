import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/game_controller.dart';
import '../widgets/bite_card_view.dart';
import '../widgets/bonus_inventory_sheet.dart';
import '../widgets/bonus_reveal_view.dart';
import '../widgets/choose_size_view.dart';
import '../widgets/coin_flip_view.dart';
import '../widgets/festive_background.dart';
import '../widgets/malus_view.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  void _openBonusInventory(BuildContext context, GameController game) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BonusInventorySheet(game: game, player: game.currentPlayer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();
    final bonusCount = game.currentPlayer.bonusInventory.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(game.currentPlayer.name),
        actions: [
          IconButton(
            onPressed: () => _openBonusInventory(context, game),
            icon: Badge(
              label: Text('$bonusCount'),
              isLabelVisible: bonusCount > 0,
              child: const Icon(Icons.shield_outlined),
            ),
          ),
        ],
      ),
      body: FestiveBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
                child: Center(child: _buildPhaseView(context, game)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhaseView(BuildContext context, GameController game) {
    switch (game.phase) {
      case TurnPhase.chooseSize:
        return ChooseSizeView(game: game);
      case TurnPhase.flipping:
        return CoinFlipView(game: game);
      case TurnPhase.resolveMalus:
        return MalusView(game: game);
      case TurnPhase.revealBonus:
        return BonusRevealView(game: game);
      case TurnPhase.showCard:
        return BiteCardView(game: game);
      case TurnPhase.turnEnd:
        return _TurnEndView(game: game);
    }
  }
}

class _TurnEndView extends StatelessWidget {
  const _TurnEndView({required this.game});

  final GameController game;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("🎉", style: TextStyle(fontSize: 56)),
        const SizedBox(height: 16),
        Text(
          "Tour terminé !",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: game.endTurn,
          child: const Text("Joueur suivant"),
        ),
      ],
    );
  }
}
