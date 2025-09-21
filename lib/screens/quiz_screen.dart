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
    final progress = (currentQuestionIndex + 1) / widget.questionSet.questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF0A0A0A),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.questionSet.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF00BCD4),
                        Color(0xFF0097A7),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'CIVION',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Question ${currentQuestionIndex + 1} of ${widget.questionSet.questions.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress indicator
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.transparent,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00BCD4)),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Category chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00BCD4).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF00BCD4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        currentQuestion.category,
                        style: const TextStyle(
                          color: Color(0xFF00BCD4),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Question
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Text(
                        currentQuestion.question,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Options
                    ...currentQuestion.options.asMap().entries.map((entry) {
                      final index = entry.key;
                      final option = entry.value;
                      final isSelected = userAnswers[currentQuestionIndex] == index;
                      final isCorrect = index == currentQuestion.correctAnswer;
                      final showCorrectAnswer = showResults;
                      
                      Color? backgroundColor;
                      Color? textColor;
                      Color? borderColor;
                      IconData? icon;
                      
                      if (showCorrectAnswer) {
                        if (isCorrect) {
                          backgroundColor = Colors.green.withOpacity(0.1);
                          textColor = Colors.green.shade300;
                          borderColor = Colors.green;
                          icon = Icons.check_circle;
                        } else if (isSelected && !isCorrect) {
                          backgroundColor = Colors.red.withOpacity(0.1);
                          textColor = Colors.red.shade300;
                          borderColor = Colors.red;
                          icon = Icons.cancel;
                        } else {
                          backgroundColor = Colors.white.withOpacity(0.05);
                          textColor = Colors.white.withOpacity(0.6);
                          borderColor = Colors.white.withOpacity(0.1);
                        }
                      } else if (isSelected) {
                        backgroundColor = const Color(0xFF00BCD4).withOpacity(0.2);
                        textColor = const Color(0xFF00BCD4);
                        borderColor = const Color(0xFF00BCD4);
                        icon = Icons.radio_button_checked;
                      } else {
                        backgroundColor = Colors.white.withOpacity(0.05);
                        textColor = Colors.white;
                        borderColor = Colors.white.withOpacity(0.1);
                        icon = Icons.radio_button_unchecked;
                      }
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: borderColor,
                              width: 2,
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => selectAnswer(index),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: backgroundColor,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    icon,
                                    color: textColor,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: textColor,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    
                    const SizedBox(height: 32),
                    
                    // Navigation buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentQuestionIndex > 0)
                          OutlinedButton.icon(
                            onPressed: previousQuestion,
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Previous'),
                          )
                        else
                          const SizedBox(width: 120),
                        
                        if (!showResults)
                          FilledButton.icon(
                            onPressed: isLastQuestion && allQuestionsAnswered ? submitQuiz : nextQuestion,
                            icon: Icon(isLastQuestion ? Icons.check : Icons.arrow_forward),
                            label: Text(isLastQuestion ? 'Submit Quiz' : 'Next'),
                          )
                        else
                          FilledButton.icon(
                            onPressed: resetQuiz,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again'),
                          ),
                      ],
                    ),
                    
                    // Results
                    if (showResults) ...[
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF00BCD4),
                              Color(0xFF0097A7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.emoji_events,
                              size: 48,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Quiz Complete!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'You scored $correctAnswers out of ${widget.questionSet.questions.length}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Percentage: ${((correctAnswers / widget.questionSet.questions.length) * 100).toStringAsFixed(1)}%',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.home),
                                  label: const Text('Back to Home'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                ),
                                FilledButton.icon(
                                  onPressed: resetQuiz,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Try Again'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF00BCD4),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
