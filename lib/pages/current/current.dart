import 'package:flutter/material.dart';
import 'package:meal_mind/models/full_recipe.dart';
import 'package:provider/provider.dart';

import '../recipes/state/recipe_state.dart';
import '../components/state/main_navigation_state.dart';
import '../components/copyable_text_widget.dart';

class CurrentPage extends StatefulWidget {
  const CurrentPage({super.key});

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  final ScrollController _scrollController = ScrollController();
  bool _hasShownSnackBar = false;
  String? _lastRecipeName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final recipeState = context.read<RecipeState>();
    final navigationState = context.read<NavigationState>();
    final recipe = recipeState.selectedRecipeFull;

    _maybeResetSnackBarFlag(recipeState);
    _maybeScrollToTop(recipe);
    _maybeShowSnackBar(recipe, recipeState, navigationState);
  }

  void _maybeResetSnackBarFlag(RecipeState recipeState) {
    final name = recipeState.history.isNotEmpty ? recipeState.history.last : "";
    if (name != _lastRecipeName) {
      _lastRecipeName = name;
      _hasShownSnackBar = false;
    }
  }

  void _maybeScrollToTop(dynamic recipe) {
    if (recipe != null && _scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _maybeShowSnackBar(
    FullRecipe? recipe,
    RecipeState recipeState,
    NavigationState navigationState,
  ) {
    if (recipe != null &&
        !recipeState.couldSelectRecipe &&
        navigationState.selectedIndex == 1 &&
        !_hasShownSnackBar) {
      _hasShownSnackBar = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Could not find the recipe. Showing previous recipe.",
            ),
            duration: Duration(seconds: 2),
          ),
        );
        recipeState.couldSelectRecipe = true;
      });
    }
  }

  Widget _titleCard(String text, {double fontSize = 20}) => Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
      ),
    ),
  );

  Widget _textCard(
    String text, {
    style = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  }) => Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: style),
    ),
  );

  Widget _copyableCard(
    String text, {
    showCopyIcon = false,
    style = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  }) => Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CopyableTextWidget(
        text: text,
        showCopyIcon: showCopyIcon,
        style: style,
      ),
    ),
  );

  Widget _sectionCard(
    String title,
    String text,
    Size size, {
    style = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  }) => Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: style),
          SizedBox(height: 8, width: size.width),
          CopyableTextWidget(text: text, showCopyIcon: false),
        ],
      ),
    ),
  );

  List<String> _addPositions(List<String> list) =>
      List.generate(list.length, (i) => "${i + 1}. ${list[i]}");

  @override
  Widget build(BuildContext context) {
    final recipeState = context.watch<RecipeState>();
    final navigationState = context.watch<NavigationState>();
    final recipe = recipeState.selectedRecipeFull;
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    if (recipe == null &&
        !recipeState.couldSelectRecipe &&
        navigationState.selectedIndex == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not find the recipe."),
            duration: Duration(seconds: 2),
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: theme.canvasColor,
      body: SafeArea(
        child: recipe == null
            ? const Center(
                child: Text(
                  "No recipe selected",
                  style: TextStyle(fontSize: 50),
                ),
              )
            : Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _titleCard("Current Recipe", fontSize: 26),

                      const SizedBox(height: 16),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(recipe.imageUrl, height: 320),
                      ),

                      const SizedBox(height: 16),

                      _copyableCard(recipe.name),

                      if (recipe.alternateName != "N/a")
                        _textCard("Alternative name: ${recipe.alternateName}"),

                      _sectionCard(
                        "Ingredients",
                        _addPositions(recipe.ingredients).join("\n"),
                        size,
                      ),
                      _sectionCard(
                        "Measures",
                        _addPositions(recipe.measures).join("\n"),
                        size,
                      ),
                      _sectionCard("Instructions", recipe.instructions, size),

                      _textCard("Additional Information:"),
                      _copyableCard(
                        "Area: ${recipe.area}\nCategory: ${recipe.category}\nYoutube Link: ${recipe.youtubeLink}",
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
