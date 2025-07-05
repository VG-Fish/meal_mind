import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../recipes/state/recipe_state.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RecipeState>(context);
    final recipe = state.selectedRecipe;

    return Scaffold(
      body: SafeArea(
        child: recipe == null
            ? Center(child: Text("No recipe selected"))
            : Column(
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Image.network(recipe.imageUrl),
                ],
              ),
      ),
    );
  }
}
