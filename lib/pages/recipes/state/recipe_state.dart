import 'package:flutter/material.dart';

import '../../../models/short_recipe.dart';
import '../../../models/full_recipe.dart';
import '../../../services/local_storage.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class RecipeState extends ChangeNotifier {
  List<String> favorites = [];
  List<String> history = [];
  List<String> categories = ['All'];
  List<ShortRecipe> currentRecipes = [];

  ShortRecipe? selectedRecipeShort;
  FullRecipe? selectedRecipeFull;
  bool couldSelectRecipe = true;
  bool isLoading = false;
  String currentCategory = 'All';

  final Map<String, List<ShortRecipe>> _cache = {};
  final storage = ListLocalStorage();

  RecipeState() {
    loadFavorites();
    loadHistory();
    loadCategories();
  }

  Future<void> _fetchFullRecipe(ShortRecipe recipe) async {
    String name = recipe.name;
    final response = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?s=$name"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data["meals"] != null) {
        couldSelectRecipe = true;
        selectedRecipeFull = FullRecipe.fromJson(data["meals"][0]);
      } else {
        couldSelectRecipe = false;
      }
    }
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    favorites = await storage.getKey("favorites");
    notifyListeners();
  }

  Future<void> loadHistory() async {
    history = await storage.getKey("search_history");
    notifyListeners();
  }

  Future<void> loadCategories() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      categories = ['All'];
      categories.addAll(
        List<String>.from(
          (data['categories'] as List).map(
            (category) => category['strCategory'],
          ),
        ),
      );
      notifyListeners();
    }
  }

  Future<void> fetchRecipes(int amount) async {
    if (_cache.containsKey(currentCategory)) {
      currentRecipes = _cache[currentCategory]!;
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();
    List<ShortRecipe> fetched = [];

    if (currentCategory == "All") {
      for (int i = 0; i < amount; i++) {
        final response = await http.get(
          Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final meal = data['meals'][0];
          fetched.add(ShortRecipe.fromJson(meal));
        }
      }
    } else {
      final response = await http.get(
        Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=$currentCategory',
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final meals = (data['meals'] as List).take(amount);
        fetched = meals
            .map<ShortRecipe>((meal) => ShortRecipe.fromJson(meal))
            .toList();
      }
    }

    _cache[currentCategory] = fetched;
    currentRecipes = fetched;
    isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(String name) {
    if (favorites.contains(name)) {
      favorites.remove(name);
      storage.removeValueFromKey("favorites", name);
    } else {
      favorites.add(name);
      storage.addValueToKey("favorites", name);
    }
    notifyListeners();
  }

  void addToHistory(String term) {
    history.add(term);
    storage.addValueToKey("search_history", term);
    notifyListeners();
  }

  void setCategory(String category, int amount) {
    currentCategory = category;
    fetchRecipes(amount);
  }

  void selectRecipe(ShortRecipe recipe) {
    selectedRecipeShort = recipe;
    couldSelectRecipe = true;
    notifyListeners();

    _fetchFullRecipe(recipe);
    notifyListeners();
  }
}
