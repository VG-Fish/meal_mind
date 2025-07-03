import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/recipe_search_bar.dart';
import 'components/recipe_tab.dart';

import 'dart:convert';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPage();
}

class _RecipesPage extends State<RecipesPage> {
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    if (categories.isEmpty) {
      _loadCategories();
    }
  }

  Future<void> _loadCategories() async {
    var response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (response.statusCode != 200) {
      print("Error getting categories.");
      return;
    }

    Map<String, dynamic> data = jsonDecode(response.body);

    setState(() {
      categories = List<String>.from(
        data["categories"].map((cat) => cat["strCategory"]),
      );
      categories.insert(0, "All");
    });
  }

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
                    // All Recipes tab
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                for (var category in categories)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                              Colors.deepPurple,
                                            ),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                              Colors.white,
                                            ),
                                      ),
                                      child: Text(category),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              padding: const EdgeInsets.all(8),
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              children: List.generate(4, (index) {
                                return RecipeTab(
                                  name: "D",
                                  imageLink:
                                      "https://www.themealdb.com/images/media/meals/sytuqu1511553755.jpg",
                                  onTap: () {},
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Favorites tab
                    Center(child: Text("Favorites")),

                    // History tab
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
