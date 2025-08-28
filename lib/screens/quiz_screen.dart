import 'dart:math';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> allQuestions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'London', 'Berlin', 'Rome'],
      'answer': 'Paris'
    },
    {
      'question': 'Which animal is known as the King of the Jungle?',
      'options': ['Lion', 'Tiger', 'Elephant', 'Monkey'],
      'answer': 'Lion'
    },
    {
      'question': 'How many days are there in a week?',
      'options': ['5', '6', '7', '8'],
      'answer': '7'
    },
    {
      'question': 'What color do you get when you mix red and yellow?',
      'options': ['Green', 'Orange', 'Purple', 'Blue'],
      'answer': 'Orange'
    },
    {
      'question': 'Which is the largest planet in our solar system?',
      'options': ['Earth', 'Mars', 'Jupiter', 'Venus'],
      'answer': 'Jupiter'
    },
    {
      'question': 'What do bees make?',
      'options': ['Milk', 'Honey', 'Bread', 'Juice'],
      'answer': 'Honey'
    },
    {
      'question': 'Which shape has three sides?',
      'options': ['Square', 'Triangle', 'Circle', 'Rectangle'],
      'answer': 'Triangle'
    },
    {
      'question': 'What is the opposite of hot?',
      'options': ['Cold', 'Warm', 'Cool', 'Boiling'],
      'answer': 'Cold'
    },
    {
      'question': 'Which fruit is yellow and long?',
      'options': ['Apple', 'Banana', 'Grapes', 'Orange'],
      'answer': 'Banana'
    },
    {
      'question': 'How many legs does a spider have?',
      'options': ['6', '8', '4', '10'],
      'answer': '8'
    },
    {
      'question': 'Which month comes after March?',
      'options': ['April', 'May', 'June', 'July'],
      'answer': 'April'
    },
    {
      'question': 'What do you call a baby dog?',
      'options': ['Kitten', 'Puppy', 'Cub', 'Calf'],
      'answer': 'Puppy'
    },
    {
      'question': 'Which is the fastest land animal?',
      'options': ['Cheetah', 'Lion', 'Horse', 'Tiger'],
      'answer': 'Cheetah'
    },
    {
      'question': 'What do you use to write on a blackboard?',
      'options': ['Pen', 'Chalk', 'Pencil', 'Brush'],
      'answer': 'Chalk'
    },
    {
      'question': 'Which is the tallest animal?',
      'options': ['Elephant', 'Giraffe', 'Horse', 'Camel'],
      'answer': 'Giraffe'
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
      'answer': 'Mars'
    },
    {
      'question': 'What do you call water in its solid state?',
      'options': ['Ice', 'Steam', 'Rain', 'Snow'],
      'answer': 'Ice'
    },
    {
      'question': 'Which bird can mimic human speech?',
      'options': ['Parrot', 'Crow', 'Sparrow', 'Pigeon'],
      'answer': 'Parrot'
    },
    {
      'question': 'Which is the smallest continent?',
      'options': ['Asia', 'Australia', 'Europe', 'Africa'],
      'answer': 'Australia'
    },
    {
      'question': 'What is H2O commonly known as?',
      'options': ['Salt', 'Water', 'Oxygen', 'Hydrogen'],
      'answer': 'Water'
    },
  ];

  late List<Map<String, dynamic>> questions;
  int currentQuestion = 0;
  int correct = 0;
  int wrong = 0;
  String? selectedOption;
  bool showResult = false;
  bool answered = false;
  List<int> lastQuizIndexes = [];

  @override
  void initState() {
    super.initState();
    _generateQuiz();
  }

  List<int> unusedIndexes = [];
  List<int> usedIndexes = [];

  void _generateQuiz() {
  final rand = Random();

  // Initialize unusedIndexes if empty or less than 10 left
  if (unusedIndexes.length < 10) {
    unusedIndexes = List.generate(allQuestions.length, (i) => i);
    unusedIndexes.shuffle(rand);
  }

  // Pick 10 unique questions from unusedIndexes
  List<int> newQuizIndexes = unusedIndexes.take(10).toList();
  unusedIndexes.removeWhere((idx) => newQuizIndexes.contains(idx));

  questions = newQuizIndexes.map((i) => allQuestions[i]).toList();

  currentQuestion = 0;
  correct = 0;
  wrong = 0;
  selectedOption = null;
  showResult = false;
  answered = false;
  setState(() {});
}
  void _selectOption(String option) {
    if (answered) return;
    setState(() {
      selectedOption = option;
      answered = true;
      if (option == questions[currentQuestion]['answer']) {
        correct++;
      } else {
        wrong++;
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedOption = null;
        answered = false;
      });
    } else {
      setState(() {
        showResult = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: showResult
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Quiz Completed!",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Correct Answers: $correct",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Wrong Answers: $wrong",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _generateQuiz,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      ),
                      child: const Text(
                        "Quiz Again",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question ${currentQuestion + 1} of ${questions.length}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    questions[currentQuestion]['question'],
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ...List.generate(4, (i) {
                    final option = questions[currentQuestion]['options'][i];
                    final isSelected = selectedOption == option;
                    final isCorrect = answered && option == questions[currentQuestion]['answer'];
                    final isWrong = answered && isSelected && !isCorrect;
                    Color color;
                    if (isCorrect) {
                      color = Colors.green;
                    } else if (isWrong) {
                      color = Colors.red;
                    } else if (isSelected) {
                      color = Colors.deepPurple;
                    } else {
                      color = Colors.deepPurple.shade50;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Material(
                        color: color,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: answered ? null : () => _selectOption(option),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 20,
                                color: (isCorrect || isWrong || isSelected)
                                    ? Colors.white
                                    : Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 32),
                  if (answered)
                    Text(
                      selectedOption == questions[currentQuestion]['answer']
                          ? "Correct!"
                          : "Incorrect!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: selectedOption == questions[currentQuestion]['answer']
                            ? Colors.green
                            : Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (answered) const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: answered ? _nextQuestion : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      ),
                      child: Text(
                        currentQuestion == questions.length - 1 ? "Finish" : "Next",
                        style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}