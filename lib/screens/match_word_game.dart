import 'dart:math';
import 'package:flutter/material.dart';

class MatchWordGame extends StatefulWidget {
  const MatchWordGame({Key? key}) : super(key: key);

  @override
  State<MatchWordGame> createState() => _MatchWordGameState();
}

class _MatchWordGameState extends State<MatchWordGame> {
  final List<Map<String, dynamic>> items = [
    {'name': 'Apple', 'icon': Icons.apple},
    {'name': 'Banana', 'emoji': '🍌'},
    {'name': 'Car', 'icon': Icons.directions_car},
    {'name': 'Dog', 'emoji': '🐶'},
    {'name': 'Cat', 'emoji': '🐱'},
    {'name': 'Fish', 'emoji': '🐟'},
    {'name': 'Bus', 'icon': Icons.directions_bus},
    {'name': 'Book', 'icon': Icons.menu_book},
    {'name': 'Star', 'icon': Icons.star},
    {'name': 'Heart', 'icon': Icons.favorite},
    {'name': 'Grapes', 'emoji': '🍇'},
    {'name': 'Tiger', 'emoji': '🐯'},
    {'name': 'Rabbit', 'emoji': '🐰'},
    {'name': 'Deer', 'emoji': '🦌'},
    {'name': 'Leopard', 'emoji': '🐆'},
    {'name': 'House', 'emoji': '🏠'},
    {'name': 'Egg', 'emoji': '🥚'},
  ];

  late Map<String, dynamic> _currentItem;
  late List<Map<String, dynamic>> _options;
  String? _selected;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final rand = Random();
    // 4 unique random options
    _options = [];
    final usedIndexes = <int>{};
    while (_options.length < 4) {
      int idx = rand.nextInt(items.length);
      if (!usedIndexes.contains(idx)) {
        _options.add(items[idx]);
        usedIndexes.add(idx);
      }
    }
    // Sahi answer randomly select karo
    _currentItem = _options[rand.nextInt(_options.length)];
    _selected = null;
    _showResult = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match the Word', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF232526),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Which is the correct word for this icon?",
              style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            // Show icon or emoji
            _currentItem['icon'] != null
                ? Icon(_currentItem['icon'], size: 80, color: Colors.deepPurple)
                : Text(
                    _currentItem['emoji'] ?? '',
                    style: const TextStyle(fontSize: 80),
                  ),
            const SizedBox(height: 32),
            ..._options.map((option) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _showResult
                      ? (option == _currentItem
                          ? Colors.green
                          : (_selected == option['name'] ? Colors.red : Colors.white))
                      : Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _showResult
                    ? null
                    : () {
                        setState(() {
                          _selected = option['name'];
                          _showResult = true;
                        });
                      },
                child: Text(
                  option['name'],
                  style: TextStyle(
                    fontSize: 28,
                    color: _showResult
                        ? (option == _currentItem
                            ? Colors.white
                            : (_selected == option['name'] ? Colors.white : Colors.deepPurple))
                        : Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
            const SizedBox(height: 24),
            if (_showResult && _selected != null)
              Text(
                _selected == _currentItem['name'] ? "Correct!" : "Incorrect!",
                style: TextStyle(
                  color: _selected == _currentItem['name'] ? Colors.green : Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (_showResult)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: _generateQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}