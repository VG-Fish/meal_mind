class ShortRecipe {
  final String name;
  final String imageUrl;

  ShortRecipe({required this.name, this.imageUrl = ""});

  factory ShortRecipe.fromJson(Map<String, dynamic> json) {
    return ShortRecipe(name: json['strMeal'], imageUrl: json['strMealThumb']);
  }
}
