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
    _options = [];
    final usedIndexes = <int>{};
    while (_options.length < 4) {
      int idx = rand.nextInt(items.length);
      if (!usedIndexes.contains(idx)) {
        _options.add(items[idx]);
        usedIndexes.add(idx);
      }
    }
    _currentItem = _options[rand.nextInt(_options.length)];
    _selected = null;
    _showResult = false;
    setState(() {});
  }

  Widget _buildOption(Map<String, dynamic> option) {
    bool isAnswered = _showResult;
    bool isSelected = _selected == option['name'];
    bool isCorrect = option == _currentItem;

    Color color = Colors.deepPurple;
    if (isAnswered && isCorrect) {
      color = Colors.green;
    } else if (isAnswered && isSelected && !isCorrect) {
      color = Colors.red;
    } else if (!isAnswered) {
      color = Colors.deepPurple;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: isAnswered ? null : () {
            setState(() {
              _selected = option['name'];
              _showResult = true;
            });
          },
          child: Container(
            width: double.infinity,
            height: 70,
            alignment: Alignment.center,
            child: Text(
              option['name'],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match the Word'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Match the Word",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                "Which is the correct word for this icon?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
                child: _currentItem['icon'] != null
                    ? Icon(_currentItem['icon'], size: 64, color: Colors.deepPurple)
                    : Text(
                        _currentItem['emoji'] ?? '',
                        style: const TextStyle(fontSize: 64),
                      ),
              ),
              const SizedBox(height: 32),
              ..._options.map(_buildOption).toList(),
              const SizedBox(height: 24),
              if (_showResult && _selected != null)
                Text(
                  _selected == _currentItem['name'] ? "Correct!" : "Incorrect!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _selected == _currentItem['name'] ? Colors.green : Colors.red,
                  ),
                ),
              if (_showResult)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                    onPressed: _generateQuestion,
                    child: const Text("Next", style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}