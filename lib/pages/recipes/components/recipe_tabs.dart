import 'package:flutter/material.dart';

import 'recipe_tab.dart';

import 'package:http/http.dart' as http;

import 'dart:math';
import 'dart:convert';

class RecipeTabs extends StatefulWidget {
  final String category;
  final int amount;
  final VoidCallback onTap;

  const RecipeTabs({
    super.key,
    required this.category,
    required this.amount,
    required this.onTap,
  });

  @override
  State<RecipeTabs> createState() => _RecipeTabsState();
}

class _RecipeTabsState extends State<RecipeTabs> {
  static final Map<String, List<Map<String, String>>> _recipesCache = {};
  List<Map<String, String>> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.category != "All") {
      _getRecipesFromCategory(widget.category);
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getRecipesFromCategory(String category) async {
    if (_recipesCache.containsKey(category)) {
      recipes = _recipesCache[category]!;
      setState(() {
        isLoading = false;
      });
      return;
    }

    final response = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category',
      ),
    );

    if (response.statusCode != 200) {
      print("Error getting categories.");
      setState(() {
        isLoading = false;
      });
      return;
    }

    final data = jsonDecode(response.body);
    final meals = data["meals"] as List<dynamic>?;

    if (meals != null) {
      for (int i = 0; i < min(widget.amount, meals.length); i++) {
        final currentRecipe = meals[i];
        recipes.add({
          "recipeName": currentRecipe["strMeal"],
          "recipeImageLink": currentRecipe["strMealThumb"],
        });
      }
      _recipesCache[category] = recipes;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (recipes.isEmpty) {
      return const Center(child: Text("No recipes found."));
    }
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(8),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: recipes.map((recipe) {
        return RecipeTab(
          name: recipe["recipeName"]!,
          imageLink: recipe["recipeImageLink"]!,
          onTap: widget.onTap,
        );
      }).toList(),
    );
  }
}
