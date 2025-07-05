import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/recipe_state.dart';

import 'recipe_tab.dart';
import '../../current/current.dart';

class RecipeTabs extends StatelessWidget {
  const RecipeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RecipeState>(context);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.currentRecipes.isEmpty) {
      return const Center(child: Text("No recipes found"));
    }

    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(8),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: state.currentRecipes.map((recipe) {
        return RecipeTab(
          name: recipe.name,
          imageUrl: recipe.imageUrl,
          isLiked: state.favorites.contains(recipe.name),
          onTap: () {
            state.selectRecipe(recipe);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CurrentPage()),
            );
          },
          onFavorite: () => state.toggleFavorite(recipe.name),
        );
      }).toList(),
    );
  }
}
