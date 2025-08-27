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
    // aur bhi add kar sakte hain
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
        title: const Text('Find the Color', style: TextStyle(color: Colors.white)),
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
            Text(
              "Tap the color: ${_currentColor['name']}",
              style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: _options.map((option) {
                final isCorrect = option == _currentColor;
                final isSelected = _selected == option;
                Color borderColor = Colors.white;
                if (_showResult) {
                  if (isCorrect) borderColor = Colors.green;
                  else if (isSelected) borderColor = Colors.red;
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
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: option['color'],
                      shape: BoxShape.circle,
                      border: Border.all(color: borderColor, width: 5),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
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