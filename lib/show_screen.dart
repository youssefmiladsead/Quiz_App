import 'package:flutter/material.dart';
import 'package:taskflutter/screens/score_screen.dart';
import '../globals.dart' as globals;

class ShowScreen extends StatelessWidget {
  final Map<String, dynamic> category;
  final int score;
  final int numOfQuestions;

  const ShowScreen({
    super.key,
    required this.category,
    required this.score,
    required this.numOfQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final userAnswers = globals.userAnswers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Answers'),
        backgroundColor: category['categoryColor'],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: userAnswers.length,
              itemBuilder: (context, index) {
                final answerData = userAnswers[index];
                final question = answerData['question'] ?? '';
                final selectedAnswer = answerData['selectedAnswer'] ?? '';
                final correctAnswer = answerData['correctAnswer'] ?? '';

                bool isCorrect = selectedAnswer == correctAnswer;

                return Card(
                  color: isCorrect ? Colors.green[100] : Colors.red[100],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text('Your answer: $selectedAnswer'),
                        const SizedBox(height: 4),
                        Text('Correct answer: $correctAnswer'),
                      ],
                    ),
                    trailing: Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScoreScreen(
                      score: score,
                      numOfQuestions: numOfQuestions,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: category['categoryColor'],
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Show Score'),
            ),
          ),
        ],
      ),
    );
  }
}
