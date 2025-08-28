import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class StoriesScreen extends StatelessWidget {
  StoriesScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> stories = [
    {
      'title': 'The Thirsty Crow',
      'content': '''
Once upon a time, in a hot summer, a thirsty crow was flying in search of water. He looked everywhere but could not find any. At last, he saw a pot with a little water at the bottom. The crow tried to reach the water but his beak could not touch it. He thought hard and got an idea. He picked up small stones and dropped them one by one into the pot. Slowly, the water rose up. The crow drank the water and flew away happily.

MORAL: Where there is a will, there is a way.
'''
    },
    {
      'title': 'The Lion and the Mouse',
      'content': '''
Once a lion was sleeping in the forest. A little mouse began running up and down on him. This awakened the lion, who placed his huge paw on the mouse and opened his big jaws to swallow him. "Pardon me, O King," cried the little mouse. "Forgive me this time. I shall never forget it. Who knows, I may be able to help you someday." The lion was so tickled by the idea of the mouse helping him that he lifted his paw and let him go.

Some days later, the lion was caught in a net. The mouse heard his roar and ran to help. He gnawed the net with his sharp teeth and set the lion free.

MORAL: Kindness is never wasted.
'''
    },
    {
      'title': 'The Hare and the Tortoise',
      'content': '''
A hare was making fun of the tortoise for being so slow. "Do you ever get anywhere?" he asked with a mocking laugh. "Yes," replied the tortoise, "and I get there sooner than you think. I'll run you a race and prove it." The hare was amused and agreed to the race.

They started the race. The hare ran very fast and soon left the tortoise far behind. He thought he would rest for a while and fell asleep. The tortoise kept going slowly but steadily and soon passed the sleeping hare. When the hare woke up, he saw the tortoise near the finish line. The hare ran as fast as he could, but the tortoise had already won the race.

MORAL: Slow and steady wins the race.
'''
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stories'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: stories.length,
        padding: const EdgeInsets.all(24),
        itemBuilder: (context, index) {
          final story = stories[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              title: Text(
                story['title']!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoryReadScreen(
                        title: story['title']!,
                        content: story['content']!,
                      ),
                    ),
                  );
                },
                child: const Text("Read", style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StoryReadScreen extends StatefulWidget {
  final String title;
  final String content;
  const StoryReadScreen({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  State<StoryReadScreen> createState() => _StoryReadScreenState();
}

class _StoryReadScreenState extends State<StoryReadScreen> {
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;
  bool isPaused = false;
  int _currentCharIndex = 0;
  late String storyText;
  late String moral;

  @override
  void initState() {
    super.initState();
    final parts = widget.content.split(RegExp(r'\nMORAL:'));
    storyText = parts[0].trim();
    moral = parts.length > 1 ? parts[1].trim() : '';
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
        isPaused = false;
        _currentCharIndex = 0;
      });
    });
    flutterTts.setCancelHandler(() {
      setState(() {
        isPlaying = false;
        isPaused = false;
      });
    });
    flutterTts.setPauseHandler(() {
      setState(() {
        isPlaying = false;
        isPaused = true;
      });
    });
    flutterTts.setContinueHandler(() {
      setState(() {
        isPlaying = true;
        isPaused = false;
      });
    });
    flutterTts.setStartHandler(() {
      setState(() {
        isPlaying = true;
        isPaused = false;
      });
    });
  }

  Future<void> _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    if (isPaused) {
      if (kIsWeb) {
        // Web: resume not supported, so start from beginning
        await flutterTts.speak(storyText);
      } else {
        // Mobile: resume from where paused
        await flutterTts.speak(storyText.substring(_currentCharIndex));
      }
    } else {
      await flutterTts.speak(storyText.substring(_currentCharIndex));
    }
    setState(() {
      isPlaying = true;
      isPaused = false;
    });
  }

  Future<void> _pause() async {
    await flutterTts.pause();
    setState(() {
      isPlaying = false;
      isPaused = true;
    });
  }

  Future<void> _stop() async {
    await flutterTts.stop();
    setState(() {
      isPlaying = false;
      isPaused = false;
      _currentCharIndex = 0;
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    flutterTts.setProgressHandler((String text, int start, int end, String word) {
      setState(() {
        _currentCharIndex = start;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.volume_up,
                      color: Colors.white,
                      size: 28,
                    ),
                    tooltip: isPlaying ? "Pause" : "Read Aloud",
                    onPressed: () {
                      if (isPlaying) {
                        _pause();
                      } else {
                        _speak();
                      }
                    },
                  ),
                  // Diagonal line overlay when not playing (crosses icon)
                  if (!isPlaying)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Transform.rotate(
                          angle: -0.7,
                          child: Center(
                            child: Container(
                              width: 32,
                              height: 3,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storyText,
                  style: const TextStyle(fontSize: 20, color: Colors.black87, height: 1.5),
                ),
                if (moral.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Text(
                    "MORAL:",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    moral,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}