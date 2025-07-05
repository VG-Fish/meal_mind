class Recipe {
  final String name;
  final String imageUrl;

  Recipe({required this.name, required this.imageUrl});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(name: json['strMeal'], imageUrl: json['strMealThumb']);
  }

  Map<String, dynamic> toJson() => {'strMeal': name, 'strMealThumb': imageUrl};
}
