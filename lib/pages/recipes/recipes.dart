import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/recipe_state.dart';
import 'components/recipe_tabs.dart';

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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Recipe Library",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (text) => state.addToHistory(text),
                  decoration: const InputDecoration(hintText: 'Search...'),
                ),
              ),
              TabBar(
                tabs: const [
                  Tab(text: "All Recipes"),
                  Tab(text: "Favorites"),
                  Tab(text: "History"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: state.categories
                                .map(
                                  (cat) => Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          state.setCategory(cat, 9),
                                      child: Text(cat),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const Expanded(child: RecipeTabs()),
                      ],
                    ),
                    ListView(
                      children: state.favorites
                          .map((f) => ListTile(title: Text(f)))
                          .toList(),
                    ),
                    ListView(
                      children: state.history
                          .map((h) => ListTile(title: Text(h)))
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
