import 'package:flutter/material.dart';
import 'package:meal_mind/pages/recipes/components/recipe_search_bar.dart';
import 'package:provider/provider.dart';

import 'state/recipe_state.dart';
import 'components/recipe_tabs.dart';
import '../components/copyable_text_widget.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RecipeState>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Top Text
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Recipe Library",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RecipeSearchBar(
                  onSubmit: (recipe) {
                    state.addToHistory(recipe);
                  },
                ),
              ),

              const TabBar(
                tabs: const [
                  Tab(text: "All Recipes"),
                  Tab(text: "Favorites"),
                  Tab(text: "History"),
                ],
              ),

              const Divider(height: 1),

              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        // Category Buttons
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: state.categories
                                .map(
                                  (category) => Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: ElevatedButton(
                                      onPressed: () => state.setCategory(
                                        category,
                                        9,
                                      ), // This call fetches X recipes
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
                                )
                                .toList(),
                          ),
                        ),

                        // Recipe Cards
                        const Expanded(child: RecipeTabs()),
                      ],
                    ),

                    // Favorites Tab
                    state.favorites.isEmpty
                        ? Center(child: Text("No Favorites"))
                        : ListView(
                            children: state.favorites.reversed
                                .map(
                                  (favorite) => Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: const Color.fromARGB(
                                      255,
                                      178,
                                      223,
                                      245,
                                    ),
                                    child: CopyableTextWidget(text: favorite),
                                  ),
                                )
                                .toList(),
                          ),

                    // History Tab
                    state.history.isEmpty
                        ? Center(child: Text("No History"))
                        : ListView(
                            children: state.history.reversed
                                .map(
                                  (history) => Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: const Color.fromARGB(
                                      255,
                                      178,
                                      223,
                                      245,
                                    ),
                                    child: CopyableTextWidget(text: history),
                                  ),
                                )
                                .toList(),
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
