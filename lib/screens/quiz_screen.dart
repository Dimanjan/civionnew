import 'package:flutter/material.dart';
import '../models/question_set.dart';
import '../models/question.dart';

class QuizScreen extends StatefulWidget {
  final QuestionSet questionSet;

  const QuizScreen({super.key, required this.questionSet});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  List<int?> userAnswers = [];
  bool showResults = false;
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    userAnswers = List.filled(widget.questionSet.questions.length, null);
  }

  void selectAnswer(int answerIndex) {
    if (!showResults) {
      setState(() {
        userAnswers[currentQuestionIndex] = answerIndex;
      });
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < widget.questionSet.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void submitQuiz() {
    int correct = 0;
    for (int i = 0; i < widget.questionSet.questions.length; i++) {
      if (userAnswers[i] == widget.questionSet.questions[i].correctAnswer) {
        correct++;
      }
    }
    setState(() {
      correctAnswers = correct;
      showResults = true;
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      userAnswers = List.filled(widget.questionSet.questions.length, null);
      showResults = false;
      correctAnswers = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questionSet.questions[currentQuestionIndex];
    final isLastQuestion = currentQuestionIndex == widget.questionSet.questions.length - 1;
    final allQuestionsAnswered = userAnswers.every((answer) => answer != null);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.questionSet.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / widget.questionSet.questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 16),
            
            // Question counter
            Text(
              'Question ${currentQuestionIndex + 1} of ${widget.questionSet.questions.length}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            
            // Category
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                currentQuestion.category,
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Question
            Text(
              currentQuestion.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            
            // Options
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.options.length,
                itemBuilder: (context, index) {
                  final isSelected = userAnswers[currentQuestionIndex] == index;
                  final isCorrect = index == currentQuestion.correctAnswer;
                  final showCorrectAnswer = showResults;
                  
                  Color? backgroundColor;
                  Color? textColor;
                  
                  if (showCorrectAnswer) {
                    if (isCorrect) {
                      backgroundColor = Colors.green[100];
                      textColor = Colors.green[800];
                    } else if (isSelected && !isCorrect) {
                      backgroundColor = Colors.red[100];
                      textColor = Colors.red[800];
                    }
                  } else if (isSelected) {
                    backgroundColor = Colors.blue[100];
                    textColor = Colors.blue[800];
                  }
                  
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    color: backgroundColor,
                    child: InkWell(
                      onTap: () => selectAnswer(index),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? Colors.blue : Colors.grey,
                                  width: 2,
                                ),
                                color: isSelected ? Colors.blue : Colors.transparent,
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                currentQuestion.options[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor ?? Colors.black87,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: previousQuestion,
                    child: const Text('Previous'),
                  )
                else
                  const SizedBox(width: 80),
                
                if (!showResults)
                  ElevatedButton(
                    onPressed: isLastQuestion && allQuestionsAnswered ? submitQuiz : nextQuestion,
                    child: Text(isLastQuestion ? 'Submit' : 'Next'),
                  )
                else
                  ElevatedButton(
                    onPressed: resetQuiz,
                    child: const Text('Try Again'),
                  ),
              ],
            ),
            
            // Results
            if (showResults) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  children: [
                    Text(
                      'Quiz Complete!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Score: $correctAnswers out of ${widget.questionSet.questions.length}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Percentage: ${((correctAnswers / widget.questionSet.questions.length) * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 