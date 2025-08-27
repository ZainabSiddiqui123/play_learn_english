import 'package:flutter/material.dart';
import 'word_category_screen.dart'; // Make sure this import path is correct

class WordsScreen extends StatefulWidget {
  const WordsScreen({Key? key}) : super(key: key);

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  static const List<String> alphabets = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  static const List<Color> cardColors = [
    Color(0xFFFFCDD2), Color(0xFFFFE0B2), Color(0xFFFFFF8D), Color(0xFFC8E6C9),
    Color(0xFFBBDEFB), Color(0xFFE1BEE7), Color(0xFFF8BBD0), Color(0xFFB2DFDB),
    Color(0xFFB3E5FC), Color(0xFFFFF9C4), Color(0xFFFFCCBC), Color(0xFFD1C4E9),
    Color(0xFFF0F4C3), Color(0xFFB2EBF2), Color(0xFFD7CCC8), Color(0xFFCFD8DC),
    Color(0xFFE6EE9C), Color(0xFFE1BEE7), Color(0xFFFFE082), Color(0xFFB2DFDB),
    Color(0xFFFFF59D), Color(0xFFB2EBF2), Color(0xFFF8BBD0), Color(0xFFF0F4C3),
    Color(0xFFFFF9C4),
  ];

  int _pressedIndex = -1;

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
        title: const Text('Words'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
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
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final isPressed = _pressedIndex == index;
            return GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _pressedIndex = index;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _pressedIndex = -1;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WordCategoryScreen(alphabet: alphabets[index]),
                  ),
                );
              },
              onTapCancel: () {
                setState(() {
                  _pressedIndex = -1;
                });
              },
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