import 'package:flutter/material.dart';

class RecipeSearchBar extends StatefulWidget {
  const RecipeSearchBar({super.key, required this.onSubmit});

  final void Function(String recipe) onSubmit;

  @override
  State<RecipeSearchBar> createState() => _RecipeSearchBarState();
}

class _RecipeSearchBarState extends State<RecipeSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _handleSubmit(String value) {
    if (value.trim().isEmpty) return;

    widget.onSubmit(value);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SearchBar(
        controller: _controller,
        hintText: "Enter your recipe here...",
        leading: const Icon(Icons.search),
        onSubmitted: _handleSubmit,
      ),
    );
  }
}
