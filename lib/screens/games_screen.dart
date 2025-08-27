import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.help_outline, size: 30),
            label: const Text(
              'Guess Alphabet',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 184, 53, 118),
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/guess-alphabet'),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.spellcheck, size: 30),
            label: const Text(
              'Match Word',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 54, 56, 175),
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/match-word'),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.color_lens, size: 30),
            label: const Text(
              'Find Color',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 43, 199, 121),
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/find-color'),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.memory, size: 30),
            label: const Text(
              'Memory Game',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 207, 117, 57),
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/memory-game'),
          ),
        ],
      ),
    );
  }
}