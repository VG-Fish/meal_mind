import 'package:flutter/material.dart';

class RecipeSearchBar extends StatelessWidget {
  const RecipeSearchBar({super.key, required this.onSubmit});

  final Future<void> Function(String recipe) onSubmit;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: "Enter your recipe here...",
      leading: Icon(Icons.search),
      onSubmitted: (text) {
        onSubmit(text);
      },
    );
  }
}
