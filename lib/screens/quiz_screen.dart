import 'package:flutter/material.dart';
import 'package:taskflutter/show_screen.dart';
import '../globals.dart' as globals;

class QuizScreen extends StatefulWidget {
  final Map<String, dynamic> category;

  QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 1;
  int currentScore = 0;

  @override
  void initState() {
    super.initState();
    globals.userAnswers.clear();
  }

  void selectAnswer({
    required String question,
    required String selectedAnswer,
    required String correctAnswer,
    required int score,
  }) {
    int index = globals.userAnswers
        .indexWhere((element) => element['question'] == question);

    if (index >= 0) {
      String? previousSelected = globals.userAnswers[index]['selectedAnswer'];
      int previousScore = previousSelected == correctAnswer ? 1 : 0;
      int newScore = selectedAnswer == correctAnswer ? 1 : 0;

      currentScore = currentScore - previousScore + newScore;

      globals.userAnswers[index] = {
        'question': question,
        'selectedAnswer': selectedAnswer,
        'correctAnswer': correctAnswer,
      };
    } else {
      if (selectedAnswer == correctAnswer) {
        currentScore += 1;
      }

      globals.userAnswers.add({
        'question': question,
        'selectedAnswer': selectedAnswer,
        'correctAnswer': correctAnswer,
      });
    }
  }

  bool isQuestionAnswered(String questionText) {
    return globals.userAnswers
        .any((element) => element['question'] == questionText);
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.category['questionsAndAnswers'] as List<dynamic>;
    final numOfQuestions = questions.length;
    final currentQ = questions[currentQuestion - 1];
    final questionText = currentQ['question'] as String;
    final answers = currentQ['answers'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category['categoryName']),
        backgroundColor: widget.category['categoryColor'],
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text('$currentQuestion / $numOfQuestions'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionText,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            for (int i = 0; i < answers.length; i++)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final selectedAnswer = answers[i]['answerText'] as String;
                      final score = answers[i]['score'] as int;
                      final correctAnswer = answers.firstWhere(
                        (ans) => ans['score'] == 1,
                        orElse: () => {'answerText': 'No correct answer'},
                      )['answerText'] as String;

                      selectAnswer(
                        question: questionText,
                        selectedAnswer: selectedAnswer,
                        correctAnswer: correctAnswer,
                        score: score,
                      );

                      if (currentQuestion == numOfQuestions) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => ShowScreen(
                              category: widget.category,
                              score: currentScore,
                              numOfQuestions: numOfQuestions,
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          currentQuestion++;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.category['categoryColor'],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                    ),
                    child: Text(
                      answers[i]['answerText'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentQuestion > 1
                      ? () {
                          setState(() {
                            currentQuestion--;
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Prev'),
                ),

                // ✅ علامة الاستفهام الحمراء إذا لم يتم حل السؤال
                if (!isQuestionAnswered(questionText))
                  const Icon(Icons.help_outline, color: Colors.red, size: 30),

                ElevatedButton(
                  onPressed: currentQuestion < numOfQuestions
                      ? () {
                          setState(() {
                            currentQuestion++;
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.category['categoryColor'],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Next'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
