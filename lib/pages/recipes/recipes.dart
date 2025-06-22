import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/recipe_search_bar.dart';

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

    if (data["meals"] == null) {
      print("No meals found");
      return;
    }
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Recipe Library",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RecipeSearchBar(onSubmit: searchRecipe),
              ),
              const TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "All Recipes"),
                  Tab(text: "Favorites"),
                  Tab(text: "History"),
                ],
              ),
              const Divider(height: 1),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text("All Recipes")),
                    Center(child: Text("Favorites")),
                    Center(child: Text("History")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
