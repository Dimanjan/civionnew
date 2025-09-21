import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../models/question_set.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QuestionSet> questionSets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuestionSets();
  }

  Future<void> loadQuestionSets() async {
    try {
      List<QuestionSet> sets = [];
      for (int i = 1; i <= 31; i++) {
        String jsonString = await rootBundle.loadString('assets/data/question_set_$i.json');
        Map<String, dynamic> jsonData = json.decode(jsonString);
        sets.add(QuestionSet.fromJson(jsonData));
      }
      setState(() {
        questionSets = sets;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading question sets: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nepali Civil Service MCQ'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose a Question Set',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: questionSets.length,
                      itemBuilder: (context, index) {
                        final set = questionSets[index];
                        return Card(
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizScreen(questionSet: set),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.quiz,
                                    size: 48,
                                    color: Colors.blue[600],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    set.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${set.questions.length} questions',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
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
                ],
              ),
            ),
    );
  }
} 