import 'package:flutter/material.dart';
import 'package:speech/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

final theme = ThemeData.dark();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomePage(),
    );
  }
}
