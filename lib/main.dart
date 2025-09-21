import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NepaliCivilServiceMCQApp());
}

class NepaliCivilServiceMCQApp extends StatelessWidget {
  const NepaliCivilServiceMCQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nepali Civil Service MCQ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
} 