class Food {
  final String id;
  final String name;
  final int calories;
  final double fat;
  final String description;
  final String imageUrl;

  Food({
    required this.id,
    required this.name,
    required this.calories,
    required this.fat,
    required this.description,
    required this.imageUrl,
  });

  // Factory constructor to create a Food object from JSON data
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      calories: json['calories'],
      fat: json['fat'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  // Method to convert a Food object back to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'fat': fat,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
