import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../recipes/state/recipe_state.dart';
import '../components/copyable_text_widget.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({super.key});

  List<String> _addPositions(List<String> list) {
    List<String> result = [];
    for (int i = 0; i < list.length; i++) {
      result.add("${i + 1}. ${list[i]}");
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RecipeState>(context);
    final recipe = state.selectedRecipeFull;

    final scrollController = ScrollController();
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

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

                        // Rounded image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(recipe.imageUrl, height: 320),
                        ),

                        const SizedBox(height: 16),

                        // Recipe name
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CopyableTextWidget(
                              text: recipe.name,
                              showCopyIcon: false,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        // Alternative recipe name
                        if (recipe.alternateName != "N/a")
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Alternative name: ${recipe.alternateName!}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                        // Ingredients
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
                                SizedBox(height: 8, width: size.width),
                                CopyableTextWidget(
                                  text: _addPositions(
                                    recipe.ingredients,
                                  ).join("\n"),
                                  showCopyIcon: false,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Measures
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
                                  "Measures",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8, width: size.width),
                                CopyableTextWidget(
                                  text: _addPositions(
                                    recipe.measures,
                                  ).join("\n"),
                                  showCopyIcon: false,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Instructions
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
                                  "Instructions",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8, width: size.width),
                                CopyableTextWidget(
                                  text: recipe.instructions,
                                  showCopyIcon: false,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Additional Information
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Additional Information:",
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CopyableTextWidget(
                              text:
                                  "Area: ${recipe.area}\nCategory: ${recipe.category}\nYoutube Link: ${recipe.youtubeLink}",
                              showCopyIcon: false,
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
