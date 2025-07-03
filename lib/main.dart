import 'package:flutter/material.dart';

import 'pages/components/main_screen.dart';

void main() {
  runApp(const MealMind());
}

class MealMind extends StatelessWidget {
  const MealMind({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MealMind",
      theme: ThemeData(
        brightness: Brightness.light,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      // showPerformanceOverlay: true,
      home: MainNavigation(),
    );
  }
}
