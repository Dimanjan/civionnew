class Question {
  final int id;
  final String category;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  Question({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      category: json['category'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
    };
  }
} 