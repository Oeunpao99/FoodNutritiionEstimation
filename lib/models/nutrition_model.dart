class Nutrition {
  final double protein;
  final double carbs;
  final double fats;

  Nutrition({
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      protein: json['protein'],
      carbs: json['carbs'],
      fats: json['fats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
    };
  }
}
