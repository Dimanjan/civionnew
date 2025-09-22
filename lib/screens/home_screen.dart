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
          SnackBar(
            content: Text('Error loading question sets: $e'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: SafeArea(
          child: isLoading
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading question sets...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    // Header with Logo
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            
                            // Logo
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00BCD4).withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  'assets/civion512.jpg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Fallback to letter C if image fails to load
                                    return Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFF00BCD4),
                                            Color(0xFF0097A7),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'C',
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 20),
                            
                            // App Name
                            const Text(
                              'CIVION',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 3,
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            Text(
                              'CIVIL SERVICE MCQ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.8),
                                letterSpacing: 2,
                              ),
                            ),
                            
                            const SizedBox(height: 12),
                            
                            Text(
                              'READY TO TEST YOUR KNOWLEDGE?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.7),
                                letterSpacing: 1,
                              ),
                            ),
                            
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    
                    // Question Sets List
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final set = questionSets[index];
                            final isEmpty = set.questions.isEmpty;
                            
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                      width: 1,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(0.05),
                                        Colors.white.withOpacity(0.02),
                                      ],
                                    ),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: isEmpty ? null : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QuizScreen(questionSet: set),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        children: [
                                          // Left side - Title
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  set.title.toUpperCase(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                if (!isEmpty) ...[
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.quiz,
                                                        size: 16,
                                                        color: Colors.white.withOpacity(0.7),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        '${set.questions.length} Questions',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white.withOpacity(0.7),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ] else ...[
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add_circle_outline,
                                                        size: 16,
                                                        color: Colors.white.withOpacity(0.5),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        'Empty Set',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white.withOpacity(0.5),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                          
                                          // Right side - Status
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: isEmpty
                                                        ? Colors.white.withOpacity(0.1)
                                                        : const Color(0xFF00BCD4).withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(20),
                                                    border: Border.all(
                                                      color: isEmpty
                                                          ? Colors.white.withOpacity(0.2)
                                                          : const Color(0xFF00BCD4),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    isEmpty ? 'EMPTY' : 'START',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: isEmpty
                                                          ? Colors.white.withOpacity(0.6)
                                                          : const Color(0xFF00BCD4),
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: questionSets.length,
                        ),
                      ),
                    ),
                    
                    // Footer with just spacing
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: SizedBox(height: 40),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
