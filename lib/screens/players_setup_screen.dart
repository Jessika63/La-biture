import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/game_controller.dart';
import '../widgets/festive_background.dart';
import 'game_screen.dart';

class PlayersSetupScreen extends StatefulWidget {
  const PlayersSetupScreen({super.key});

  @override
  State<PlayersSetupScreen> createState() => _PlayersSetupScreenState();
}

class _PlayersSetupScreenState extends State<PlayersSetupScreen> {
  final _controller = TextEditingController();

  void _addPlayer(GameController game) {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    game.addPlayer(name);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();

    return Scaffold(
      appBar: AppBar(title: const Text('🎉 Les joueurs')),
      body: FestiveBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Prénom',
                        labelStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.08),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onSubmitted: (_) => _addPlayer(game),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: () => _addPlayer(game),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: game.players.isEmpty
                    ? const Center(
                        child: Text(
                          'Ajoute au moins 2 joueurs',
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView.builder(
                        itemCount: game.players.length,
                        itemBuilder: (context, index) {
                          final player = game.players[index];
                          return Card(
                            color: Colors.white.withValues(alpha: 0.08),
                            child: ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(player.name),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => game.removePlayer(index),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: game.players.length >= 2
                      ? () {
                          game.startGame();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const GameScreen()),
                          );
                        }
                      : null,
                  child: const Text('Commencer la partie'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
