import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'components/search.dart';

import 'dart:convert';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  Future<void> searchRecipe(String recipe) async {
    recipe = recipe.replaceAll(" ", "%20");
    var response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$recipe'),
    );

    if (response.statusCode != 200) {
      print("Error getting recipe.");
      return;
    }
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Recipe Library",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          RecipeSearchBar(onSubmit: searchRecipe),
        ],
      ),
    );
  }
}
