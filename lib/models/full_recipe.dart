class FullRecipe {
  final String name;
  final String imageUrl;
  final String instructions;
  final List<String> ingredients;
  final List<String> measures;

  final String? alternateName;
  final String? category;
  final String? area;
  final String? tags;
  final String? youtubeLink;
  final String? source;
  final String? dateModified;
  final String? creativeCommonsConfirmed;
  final String? imageSource;

  FullRecipe({
    required this.name,
    required this.imageUrl,
    this.alternateName,
    this.category,
    this.area,
    required this.instructions,
    this.tags,
    this.youtubeLink,
    required this.ingredients,
    required this.measures,
    this.source,
    this.dateModified,
    this.creativeCommonsConfirmed,
    this.imageSource,
  });

  factory FullRecipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    // Getting all the ingredients
    int i = 1;
    while (true) {
      String? currentIngredient = json["strIngredient$i"];
      if (currentIngredient == null || currentIngredient.trim() == "") {
        break;
      }
      ingredients.add(currentIngredient);
      i++;
    }

    // Getting all the measures
    i = 1;
    while (true) {
      String? currentMeasure = json["strMeasure$i"];
      if (currentMeasure == null || currentMeasure.trim() == "") {
        break;
      }
      measures.add(currentMeasure);
      i++;
    }

    return FullRecipe(
      name: json["strMeal"],
      imageUrl: json["strMealThumb"],
      instructions: json["strInstructions"],
      ingredients: ingredients,
      measures: measures,

      alternateName: json["strMealAlternate"] ?? "N/a",
      category: json["strCategory"] ?? "N/a",
      area: json["strArea"] ?? "N/a",
      tags: json["strTags"] ?? "N/a",
      youtubeLink: json["strYoutube"] ?? "N/a",
      source: json["strSource"] ?? "N/a",
      imageSource: json["strImageSource"] ?? "N/a",
      creativeCommonsConfirmed: json["strCreativeCommonsConfirmed"] ?? "N/a",
      dateModified: json["dateModified"] ?? "N/a",
    );
  }
}
