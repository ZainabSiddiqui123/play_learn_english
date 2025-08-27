import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _buildCategoryButton(BuildContext context, String title, IconData icon, Color color, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 6,
        ),
        icon: Icon(icon, size: 32, color: Colors.white),
        label: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF8F8FF), // Optional, global theme se aa jayega
      appBar: AppBar(
        title: const Text(
          'Play & Learn English',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCategoryButton(context, "Alphabets", Icons.abc, Colors.purple, '/alphabets'),
              _buildCategoryButton(context, "Words", Icons.book, Colors.teal, '/words'),
              _buildCategoryButton(context, "Games", Icons.videogame_asset, Colors.orange, '/games'),
              _buildCategoryButton(context, "Stories", Icons.menu_book, Colors.blue, '/stories'),
              _buildCategoryButton(context, "Quiz", Icons.quiz, Colors.pink, '/quiz'),
            ],
          ),
        ),
      ),
    );
  }
}