import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/alphabets_screen.dart';
import 'screens/words_screen.dart';
import 'screens/games_screen.dart';
import 'screens/guess_alphabet_game.dart';
import 'screens/match_word_game.dart';
import 'screens/find_color_game.dart';
import 'screens/memory_game.dart';
// ...baqi screens ke imports yahan add karen

void main() {
  runApp(const PlayLearnApp());
}

class PlayLearnApp extends StatelessWidget {
  const PlayLearnApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play & Learn English',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F8FF), // Light cream
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/alphabets': (context) => const AlphabetsScreen(),
        '/words': (context) => WordsScreen(),
        '/games': (context) => const GamesScreen(),
        '/guess-alphabet': (context) => GuessAlphabetScreen(),
        '/match-word': (context) => MatchWordGame(),
        '/find-color': (context) => FindColorGame(),
        '/memory-game': (context) => MemoryGame(),
        // ...baqi routes yahan add karen
      },
    );
  }
}