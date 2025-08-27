import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Vibrant rainbow gradient for text
  Shader get _rainbowShader => const LinearGradient(
        colors: <Color>[
          Color(0xFF00C6FF), // blue
          Color(0xFF0072FF), // deep blue
          Color(0xFF8E2DE2), // purple
          Color(0xFFDA22FF), // magenta
          Color(0xFFFF512F), // orange-red
          Color(0xFFFFC837), // yellow
        ],
      ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232526), // Deep blue/grey
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Name with vibrant rainbow gradient
                    Text(
                      'Play & Learn',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = _rainbowShader,
                        letterSpacing: 2,
                        fontFamily: 'ComicSans', // If available
                        shadows: [
                          Shadow(
                            blurRadius: 16,
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'ENGLISH',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.yellow[600],
                        letterSpacing: 8,
                        fontFamily: 'ComicSans',
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            color: Colors.deepPurple.withOpacity(0.3),
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Cute tagline
                    Text(
                      "Fun way to learn English! ⭐",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.cyan[200],
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1,
                        shadows: [
                          Shadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Bold colorful progress indicator
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(seconds: 2),
                      builder: (context, value, child) {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            HSVColor.lerp(
                              HSVColor.fromAHSV(1, 220, 1, 1), // blue
                              HSVColor.fromAHSV(1, 320, 1, 1), // magenta
                              value,
                            )!
                                .toColor(),
                          ),
                          strokeWidth: 7,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}