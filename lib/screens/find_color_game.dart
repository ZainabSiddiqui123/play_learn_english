import 'dart:math';
import 'package:flutter/material.dart';

class FindColorGame extends StatefulWidget {
  const FindColorGame({Key? key}) : super(key: key);

  @override
  State<FindColorGame> createState() => _FindColorGameState();
}

class _FindColorGameState extends State<FindColorGame> {
  final List<Map<String, dynamic>> colors = [
    {'name': 'Red', 'color': Colors.red},
    {'name': 'Blue', 'color': Colors.blue},
    {'name': 'Green', 'color': Colors.green},
    {'name': 'Yellow', 'color': Colors.yellow},
    {'name': 'Purple', 'color': Colors.purple},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Pink', 'color': Colors.pink},
    {'name': 'Brown', 'color': Colors.brown},
  ];

  late Map<String, dynamic> _currentColor;
  late List<Map<String, dynamic>> _options;
  Map<String, dynamic>? _selected;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final rand = Random();
    _currentColor = colors[rand.nextInt(colors.length)];
    _options = [_currentColor];
    while (_options.length < 4) {
      var option = colors[rand.nextInt(colors.length)];
      if (!_options.contains(option)) {
        _options.add(option);
      }
    }
    _options.shuffle();
    _selected = null;
    _showResult = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find the Color'),
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
                "Find the Color",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Tap the color: ${_currentColor['name']}",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              // 2x2 Grid for color options
              SizedBox(
                width: 260,
                child: Column(
                  children: [
                    for (int row = 0; row < 2; row++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int col = 0; col < 2; col++)
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: _buildColorButton(_options[row * 2 + col]),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              if (_showResult && _selected != null)
                Text(
                  _selected == _currentColor ? "Correct!" : "Incorrect!",
                  style: TextStyle(
                    color: _selected == _currentColor ? Colors.green : Colors.red,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (_showResult)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: _generateQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
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
      ),
    );
  }

  Widget _buildColorButton(Map<String, dynamic> option) {
    final isCorrect = option == _currentColor;
    final isSelected = _selected == option;
    Color borderColor = Colors.deepPurple.shade100;
    double borderWidth = 4;
    if (_showResult) {
      if (isCorrect) {
        borderColor = Colors.green;
        borderWidth = 6;
      } else if (isSelected) {
        borderColor = Colors.red;
        borderWidth = 6;
      }
    }
    return GestureDetector(
      onTap: _showResult
          ? null
          : () {
              setState(() {
                _selected = option;
                _showResult = true;
              });
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: option['color'],
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: _showResult && isCorrect
            ? const Icon(Icons.check, color: Colors.white, size: 40)
            : null,
      ),
    );
  }
}