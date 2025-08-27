import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AlphabetsScreen extends StatefulWidget {
  const AlphabetsScreen({Key? key}) : super(key: key);

  @override
  State<AlphabetsScreen> createState() => _AlphabetsScreenState();
}

class _AlphabetsScreenState extends State<AlphabetsScreen> {
  static const List<String> alphabets = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  static const List<Color> cardColors = [
    Color(0xFFFFCDD2), // light red
    Color(0xFFFFE0B2), // light orange
    Color(0xFFFFFF8D), // light yellow
    Color(0xFFC8E6C9), // light green
    Color(0xFFBBDEFB), // light blue
    Color(0xFFE1BEE7), // light purple
    Color(0xFFF8BBD0), // light pink
    Color(0xFFB2DFDB), // teal
    Color(0xFFB3E5FC), // cyan
    Color(0xFFFFF9C4), // amber
    Color(0xFFFFCCBC), // deep orange
    Color(0xFFD1C4E9), // indigo
    Color(0xFFF0F4C3), // lime
    Color(0xFFB2EBF2), // light blue
    Color(0xFFD7CCC8), // brown
    Color(0xFFCFD8DC), // blue grey
    Color(0xFFE6EE9C), // green accent
    Color(0xFFE1BEE7), // purple accent
    Color(0xFFFFE082), // orange accent
    Color(0xFFB2DFDB), // teal accent
    Color(0xFFFFF59D), // yellow accent
    Color(0xFFB2EBF2), // cyan accent
    Color(0xFFF8BBD0), // pink accent
    Color(0xFFF0F4C3), // lime accent
    Color(0xFFFFF9C4), // yellow
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlayingFull = false;
  int _pressedIndex = -1;

  Future<void> _playLetterSound(int index) async {
    setState(() {
      _pressedIndex = index;
    });
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('audio/${alphabets[index]}.mp3'));
    await Future.delayed(const Duration(milliseconds: 180));
    setState(() {
      _pressedIndex = -1;
    });
  }

  Future<void> _toggleFullAlphabet() async {
    if (_isPlayingFull) {
      await _audioPlayer.pause();
      setState(() {
        _isPlayingFull = false;
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('audio/abc_full.mp3'));
      setState(() {
        _isPlayingFull = true;
      });
      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          _isPlayingFull = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double gridSpacing = 12;
    final int crossAxisCount = 4;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardSize = (screenWidth - (gridSpacing * (crossAxisCount + 1))) / crossAxisCount;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Alphabets'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isPlayingFull ? Icons.volume_up : Icons.volume_off,
              size: 30,
              color: Colors.white, // Always white
            ),
            tooltip: _isPlayingFull ? "Pause ABCD" : "Play full ABCD",
            onPressed: _toggleFullAlphabet,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: alphabets.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: gridSpacing,
            mainAxisSpacing: gridSpacing,
            childAspectRatio: 1, // Perfect square
          ),
          itemBuilder: (context, index) {
            final isPressed = _pressedIndex == index;
            return GestureDetector(
              onTap: () => _playLetterSound(index),
              child: AnimatedScale(
                scale: isPressed ? 0.93 : 1.0,
                duration: const Duration(milliseconds: 120),
                child: Container(
                  width: cardSize,
                  height: cardSize,
                  decoration: BoxDecoration(
                    color: cardColors[index % cardColors.length],
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      if (!isPressed)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 6,
                          offset: const Offset(2, 4),
                        ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      alphabets[index],
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'ComicSans',
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            blurRadius: 2,
                            color: Colors.white70,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}