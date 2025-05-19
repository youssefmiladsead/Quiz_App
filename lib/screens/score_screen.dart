import 'package:flutter/material.dart';
import 'category_screen.dart'; // استورد شاشة الكاتيجوري
import '../globals.dart' as globals;

class ScoreScreen extends StatelessWidget {
  final int score;
  final int numOfQuestions;

  const ScoreScreen(
      {super.key, required this.score, required this.numOfQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thank you, ${globals.username}!',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Your Score is $score / $numOfQuestions',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
                child: const Text('Back to Categories'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
