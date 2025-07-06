import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../recipes/state/recipe_state.dart';
import '../components/copyable_text_widget.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RecipeState>(context);
    final recipe = state.selectedRecipeFull;

    final scrollController = ScrollController();
    final theme = Theme.of(context);

    if (recipe != null) {
      for (var r in recipe.ingredients) {
        print(r);
      }
    }

    return Scaffold(
      backgroundColor: theme.canvasColor,
      body: SafeArea(
        child: recipe == null
            ? Center(
                child: Text(
                  "No recipe selected",
                  style: TextStyle(fontSize: 50),
                ),
              )
            : Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Current Recipe",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(recipe.imageUrl, height: 320),
                        ),

                        const SizedBox(height: 16),

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

                        const SizedBox(height: 16),

                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ingredients",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 200,
                                  child: CopyableTextWidget(
                                    text: recipe.ingredients.join("\n"),
                                    showCopyIcon: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
