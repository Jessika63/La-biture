import 'package:flutter/material.dart';

import '../widgets/festive_background.dart';
import 'players_setup_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FestiveBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🎉 🍆 🎉', style: TextStyle(fontSize: 40)),
                const SizedBox(height: 16),
                Text(
                  'Biture',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: const [
                          Shadow(color: Colors.black45, blurRadius: 12, offset: Offset(0, 4)),
                        ],
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Grosses bites, petites bites, capotes et cdr entre amis.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 48),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const PlayersSetupScreen()),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Nouvelle partie'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
