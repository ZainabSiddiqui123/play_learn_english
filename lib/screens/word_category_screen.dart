// ... existing code ...
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/word_data.dart';

class WordCategoryScreen extends StatefulWidget {
  final String alphabet;
  const WordCategoryScreen({Key? key, required this.alphabet}) : super(key: key);

  @override
  State<WordCategoryScreen> createState() => _WordCategoryScreenState();
}

class _WordCategoryScreenState extends State<WordCategoryScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _pressedIndex = -1; // for effect

  // Color mapping for all color names in your data
  Color? _getColor(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('yellow green')) return const Color(0xFF9ACD32);
    if (lower.contains('yellow')) return Colors.yellow;
    if (lower.contains('blue')) return Colors.blue;
    if (lower.contains('red')) return Colors.red;
    if (lower.contains('green')) return Colors.green;
    if (lower.contains('orange')) return Colors.orange;
    if (lower.contains('pink')) return Colors.pink;
    if (lower.contains('lime')) return Colors.lime;
    if (lower.contains('cyan')) return Colors.cyan;
    if (lower.contains('violet')) return Colors.deepPurple;
    if (lower.contains('black')) return Colors.black;
    if (lower.contains('white')) return Colors.white;
    if (lower.contains('brown')) return Colors.brown;
    if (lower.contains('gold')) return const Color(0xFFFFD700);
    if (lower.contains('peach')) return const Color(0xFFFFE5B4);
    if (lower.contains('teal')) return Colors.teal;
    if (lower.contains('silver')) return const Color(0xFFC0C0C0);
    if (lower.contains('grey') || lower.contains('gray')) return Colors.grey;
    if (lower.contains('beige')) return const Color(0xFFF5F5DC);
    if (lower.contains('amber')) return Colors.amber;
    if (lower.contains('sky blue')) return const Color(0xFF87CEEB);
    if (lower.contains('tan')) return const Color(0xFFD2B48C);
    if (lower.contains('wine')) return const Color(0xFF722F37);
    if (lower.contains('xanadu')) return const Color(0xFF738678);
    if (lower.contains('zaffre')) return const Color(0xFF0014A8);
    if (lower.contains('indigo')) return Colors.indigo;
    if (lower.contains('lavender')) return const Color.fromARGB(255, 191, 191, 241);
    if (lower.contains('fuchsia')) return const Color(0xFFFF00FF);
    if (lower.contains('emerald')) return const Color(0xFF50C878);
    if (lower.contains('crimson')) return const Color(0xFFDC143C);
    if (lower.contains('rose')) return const Color(0xFFFF007F);
    if (lower.contains('turquoise')) return const Color(0xFF40E0D0);
    if (lower.contains('ultramarine')) return const Color(0xFF3F00FF);
    if (lower.contains('quartz')) return const Color(0xFFD9D9F3);
    if (lower.contains('magenta')) return Colors.purpleAccent;
    if (lower.contains('maroon')) return const Color.fromARGB(255, 141, 33, 18);
    if (lower.contains('mint')) return Colors.greenAccent;
    if (lower.contains('purple')) return Colors.deepPurpleAccent;
    if (lower.contains('navy')) return Colors.blueAccent;
    if (lower.contains('aqua')) return const Color.fromARGB(255, 43, 192, 172);
    if (lower.contains('nude')) return const Color.fromARGB(255, 231, 149, 111);
    if (lower.contains('olive')) return const Color.fromARGB(255, 33, 66, 11);
    if (lower.contains('khaki')) return const Color.fromARGB(255, 155, 156, 92);
    if (lower.contains('jade')) return const Color.fromARGB(176, 53, 148, 69);
    if (lower.contains('ivory')) return const Color.fromARGB(255, 212, 203, 182);
    if (lower.contains('honey')) return const Color.fromARGB(255, 161, 119, 1);
    if (lower.contains('eggplant')) return const Color.fromARGB(255, 79, 6, 88);
    if (lower.contains('denim')) return const Color.fromARGB(255, 27, 83, 148);
    return Colors.grey[300];
  }

  // Auto-contrast text color for color cards
  Color _getTextColorForBackground(Color bg) {
    return bg.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  Future<void> _playTapSound() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('audio/tap.mp3'));
  }

  Widget _buildGridCategory({
    required String title,
    required List<Map<String, String>> items,
    bool isColor = false,
    required int categoryOffset, // unique offset for each category
  }) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length > 2 ? 2 : items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 18,
            childAspectRatio: 1.1, // slightly taller for long names
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            final globalIndex = categoryOffset + index;
            final isPressed = _pressedIndex == globalIndex;
            return GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _pressedIndex = globalIndex;
                });
              },
              onTapUp: (_) async {
                await _playTapSound();
                setState(() {
                  _pressedIndex = -1;
                });
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isColor
  ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _getColor(item['name'] ?? ''),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 90,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              item['name'] ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ),
      ],
    )
  : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item['emoji'] ?? '',
          style: const TextStyle(fontSize: 32),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 90,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              item['name'] ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ),
      ],
    )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animalList = (animals[widget.alphabet] ?? []).take(2).toList();
    final fruitList = (fruits[widget.alphabet] ?? []).take(2).toList();
    final vehicleList = (vehicles[widget.alphabet] ?? []).take(2).toList();
    final colorList = (colors[widget.alphabet] ?? []).take(2).toList();

    // Calculate offsets for unique index in all categories
    final animalOffset = 0;
    final fruitOffset = animalOffset + animalList.length;
    final vehicleOffset = fruitOffset + fruitList.length;
    final colorOffset = vehicleOffset + vehicleList.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.alphabet),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF8F8FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGridCategory(title: 'Animals', items: animalList, categoryOffset: animalOffset),
            _buildGridCategory(title: 'Fruits', items: fruitList, categoryOffset: fruitOffset),
            _buildGridCategory(title: 'Vehicles', items: vehicleList, categoryOffset: vehicleOffset),
            _buildGridCategory(title: 'Colors', items: colorList, isColor: true, categoryOffset: colorOffset),
            if (animalList.isEmpty && fruitList.isEmpty && vehicleList.isEmpty && colorList.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 32.0),
                child: Center(
                  child: Text(
                    "No data found for this letter.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}