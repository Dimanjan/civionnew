import 'question.dart';

class QuestionSet {
  final String id;
  final String title;
  final List<Question> questions;

  QuestionSet({
    required this.id,
    required this.title,
    required this.questions,
  });

  factory QuestionSet.fromJson(Map<String, dynamic> json) {
    return QuestionSet(
      id: json['id'],
      title: json['title'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
} 