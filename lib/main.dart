import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CivionApp());
}

class CivionApp extends StatelessWidget {
  const CivionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Civion - Civil Service MCQ',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00BCD4),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFF00BCD4),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF00BCD4),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFF00BCD4)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
