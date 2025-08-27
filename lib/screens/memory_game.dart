import 'dart:math';
import 'package:flutter/material.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({Key? key}) : super(key: key);

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  // 4 pairs (8 cards), har pair ka ek emoji ya icon
  final List<Map<String, dynamic>> _pairs = [
    {'id': 1, 'icon': '🐯'}, // Tiger
    {'id': 1, 'icon': '🐯'},
    {'id': 2, 'icon': '🐆'}, // Leopard
    {'id': 2, 'icon': '🐆'},
    {'id': 3, 'icon': '🦌'}, // Deer
    {'id': 3, 'icon': '🦌'},
    {'id': 4, 'icon': '🐰'}, // Rabbit
    {'id': 4, 'icon': '🐰'},
  ];

  late List<Map<String, dynamic>> _cards;
  List<int> _flipped = [];
  List<int> _matched = [];
  int _score = 0;
  int _moves = 0;
  int _maxMoves = 3;
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
      } else {
        setState(() {
          _moves++;
        });
      }
      setState(() {
        _flipped = [];
        _waiting = false;
        if (_moves >= _maxMoves && _matched.length != _cards.length) {
          _gameOver = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = _matched.length == _cards.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF7B294E), // Maroon velvet style
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _gameOver
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Game Over!",
                      style: TextStyle(fontSize: 32, color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Score: $_score",
                      style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _startGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text(
                        "Play Again",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            : isComplete
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "🎉 Congratulations! 🎉\nYou matched all pairs!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Score: $_score",
                          style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _startGame,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
                          Text("Score: $_score", style: const TextStyle(color: Colors.white, fontSize: 18)),
                          Text("Moves: $_moves/$_maxMoves", style: const TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        "Round-2",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ComicSans',
                        ),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: GridView.builder(
                          itemCount: _cards.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // 4 cards per row
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            final isFlipped = _flipped.contains(index) || _matched.contains(index);
                            Color cardColor;
                            switch (_cards[index]['icon']) {
                              case '🐯':
                                cardColor = const Color(0xFFB0C4DE); // light blue
                                break;
                              case '🐆':
                                cardColor = const Color(0xFF8FBC8F); // light green
                                break;
                              case '🦌':
                                cardColor = const Color(0xFFFFB6C1); // light pink
                                break;
                              case '🐰':
                                cardColor = const Color(0xFFFFFF99); // light yellow
                                break;
                              default:
                                cardColor = Colors.white;
                            }
                            return GestureDetector(
                              onTap: () => _onCardTap(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: isFlipped ? cardColor : Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 8,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: isFlipped
                                      ? Text(
                                          _cards[index]['icon'],
                                          style: const TextStyle(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ),
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