import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/components/main_navigation.dart';
import 'pages/recipes/state/recipe_state.dart';
import 'pages/components/state/main_navigation_state.dart';

void main() {
  runApp(const MealMind());
}

class MealMind extends StatelessWidget {
  const MealMind({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeState()),
        ChangeNotifierProvider(create: (_) => NavigationState()),
      ],
      child: MaterialApp(
        title: "MealMind",
        theme: ThemeData(
          canvasColor: const Color.fromARGB(255, 224, 222, 222),
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
      ),
    );
  }
}
