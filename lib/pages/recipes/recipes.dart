import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'components/recipe_search_bar.dart';
import 'components/recipe_tabs.dart';
import '../components/copyable_text_widget.dart';

import 'dart:convert';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPage();
}

class _RecipesPage extends State<RecipesPage> {
  List<String> categories = [];
  List<String> history = [];
  String currentCategory = '';

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

      setState(() {
        currentCategory = "All";
      });
    });
  }

  Future<void> searchRecipe(String recipe) async {
    setState(() {
      history.add(recipe);
    });

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
                                      onPressed: () {
                                        setState(() {
                                          currentCategory = category;
                                        });
                                      },
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
                            child: RecipeTabs(
                              key: ValueKey(currentCategory),
                              category: currentCategory,
                              amount: 9,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Favorites tab
                    Center(child: Text("Favorites")),

                    // History tab
                    history.isEmpty
                        ? Center(child: Text("History"))
                        : Column(
                            children: [
                              for (var recipe in history)
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  color: const Color.fromARGB(
                                    255,
                                    178,
                                    223,
                                    245,
                                  ),
                                  child: CopyableTextWidget(text: recipe),
                                ),
                            ],
                          ),
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
