import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../recipes/state/recipe_state.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RecipeState>(context);
    final recipe = state.selectedRecipeFull;

    return Scaffold(
      body: SafeArea(
        child: recipe == null
            ? Center(
                child: Text(
                  "No recipe selected",
                  style: TextStyle(fontSize: 50),
                ),
              )
            : Center(
                child: Column(
                  children: [
                    Text(
                      "Current Recipe",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Image.network(recipe.imageUrl, height: 240),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          recipe.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Ingredients",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListView(
                            children: recipe.ingredients.map((ingredient) {
                              return Text(ingredient);
                            }).toList(),
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
