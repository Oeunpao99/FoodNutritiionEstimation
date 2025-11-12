class FoodRecord {
  final String name;
  final int calories;
  final double fat;
  final double protein;  // Added protein
  final double sugar;    // Added sugar
  final DateTime date;

  FoodRecord({
    required this.name,
    required this.calories,
    required this.fat,
    required this.protein,  // Initialize protein
    required this.sugar,    // Initialize sugar
    required this.date,
  });
}
