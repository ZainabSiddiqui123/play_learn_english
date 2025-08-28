import 'dart:math';
import 'package:flutter/material.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({Key? key}) : super(key: key);

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  // 10 pairs (20 cards)
  final List<Map<String, dynamic>> _pairs = [
    {'id': 1, 'icon': '🐯'}, {'id': 1, 'icon': '🐯'},
    {'id': 2, 'icon': '🐆'}, {'id': 2, 'icon': '🐆'},
    {'id': 3, 'icon': '🦌'}, {'id': 3, 'icon': '🦌'},
    {'id': 4, 'icon': '🐰'}, {'id': 4, 'icon': '🐰'},
    {'id': 5, 'icon': '🐶'}, {'id': 5, 'icon': '🐶'},
    {'id': 6, 'icon': '🐱'}, {'id': 6, 'icon': '🐱'},
    {'id': 7, 'icon': '🐟'}, {'id': 7, 'icon': '🐟'},
    {'id': 8, 'icon': '🍎'}, {'id': 8, 'icon': '🍎'},
    {'id': 9, 'icon': '🍌'}, {'id': 9, 'icon': '🍌'},
    {'id': 10, 'icon': '⭐'}, {'id': 10, 'icon': '⭐'},
  ];

  late List<Map<String, dynamic>> _cards;
  List<int> _flipped = [];
  List<int> _matched = [];
  int _score = 0;
  int _moves = 0;
  final int _maxMoves = 20;
  bool _waiting = false;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _cards = List<Map<String, dynamic>>.from(_pairs);
    _cards.shuffle(Random());
    _flipped = [];
    _matched = [];
    _score = 0;
    _moves = 0;
    _gameOver = false;
    _waiting = false;
    setState(() {});
  }

  void _onCardTap(int index) async {
    if (_flipped.length == 2 || _flipped.contains(index) || _matched.contains(index) || _waiting || _gameOver) return;
    setState(() {
      _flipped.add(index);
    });

    if (_flipped.length == 2) {
      _waiting = true;
      await Future.delayed(const Duration(milliseconds: 700));
      final first = _cards[_flipped[0]];
      final second = _cards[_flipped[1]];
      if (first['id'] == second['id'] && _flipped[0] != _flipped[1]) {
        setState(() {
          _matched.addAll(_flipped);
          _score++;
        });
      }
      setState(() {
        _moves++;
        _flipped = [];
        _waiting = false;
        if (_matched.length == _cards.length || _moves >= _maxMoves) {
          _gameOver = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = _matched.length == _cards.length;
    final isMovesOver = _moves >= _maxMoves && !isComplete;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _gameOver
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isComplete)
                      const Text(
                        "🎉 Congratulations! 🎉\nYou matched all pairs!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    else
                      const Text(
                        "Game Over!\nNo moves left.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28, color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      "Score: $_score",
                      style: const TextStyle(fontSize: 22, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _startGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 6,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      ),
                      child: const Text(
                        "Play Again",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Score: $_score", style: const TextStyle(color: Colors.deepPurple, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Moves: $_moves/$_maxMoves", style: const TextStyle(color: Colors.deepPurple, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Find all matching pairs!",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: GridView.builder(
                      itemCount: _cards.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 4 cards per row
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 18,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final isFlipped = _flipped.contains(index) || _matched.contains(index);
                        return GestureDetector(
                          onTap: () => _onCardTap(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: isFlipped ? Colors.deepPurple.shade100 : Colors.white,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.deepPurple.withOpacity(0.18),
                                  blurRadius: 16,
                                  offset: const Offset(2, 6),
                                ),
                              ],
                              border: Border.all(
                                color: isFlipped ? Colors.deepPurple : Colors.deepPurple.shade200,
                                width: 4,
                              ),
                            ),
                            child: Center(
                              child: isFlipped
                                  ? Text(
                                      _cards[index]['icon'],
                                      style: const TextStyle(
                                        fontSize: 54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : const Icon(Icons.help_outline, color: Colors.deepPurple, size: 48),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}