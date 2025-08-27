import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class GuessAlphabetScreen extends StatefulWidget {
  const GuessAlphabetScreen({Key? key}) : super(key: key);

  @override
  State<GuessAlphabetScreen> createState() => _GuessAlphabetScreenState();
}

class _GuessAlphabetScreenState extends State<GuessAlphabetScreen> {
  static const List<String> alphabets = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  late String _correctLetter;
  late List<String> _options;
  String? _selected;
  String? _result;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final random = Random();
    _correctLetter = alphabets[random.nextInt(alphabets.length)];
    _options = [_correctLetter];
    while (_options.length < 4) {
      String option = alphabets[random.nextInt(alphabets.length)];
      if (!_options.contains(option)) {
        _options.add(option);
      }
    }
    _options.shuffle();
    _selected = null;
    _result = null;
    setState(() {});
    _playLetterSound();
  }

  Future<void> _playLetterSound() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('audio/${_correctLetter}.mp3'));
  }

  void _onOptionTap(String letter) {
    setState(() {
      _selected = letter;
      if (letter == _correctLetter) {
        _result = "Correct!";
      } else {
        _result = "Incorrect!";
      }
    });
    if (letter != _correctLetter) {
      _playLetterSound();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget _buildOption(String letter) {
    bool isSelected = _selected == letter;
    bool isAnswered = _result != null;
    Color color = Colors.deepPurple;
    if (isAnswered && isSelected && letter == _correctLetter) {
      color = Colors.green;
    } else if (isAnswered && isSelected && letter != _correctLetter) {
      color = Colors.red;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: isAnswered ? null : () => _onOptionTap(letter),
          child: Container(
            width: double.infinity,
            height: 70,
            alignment: Alignment.center,
            child: Text(
              letter,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Guess the Alphabet'),
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
                "Guess the Alphabet",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
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
                child: Text(
                  _correctLetter,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ..._options.map(_buildOption).toList(),
              const SizedBox(height: 24),
              if (_result != null)
                Text(
                  _result!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _result == "Correct!" ? Colors.green : Colors.red,
                  ),
                ),
              if (_result != null)
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