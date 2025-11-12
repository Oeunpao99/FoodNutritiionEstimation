import 'food_model.dart';

class DietPlan {
  final String id;
  final String name;
  final List<Food> foodItems;
  final String description;

  DietPlan({
    required this.id,
    required this.name,
    required this.foodItems,
    required this.description,
  });

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    var list = json['foodItems'] as List;
    List<Food> foodList = list.map((i) => Food.fromJson(i)).toList();

    return DietPlan(
      id: json['id'],
      name: json['name'],
      foodItems: foodList,
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'foodItems': foodItems.map((i) => i.toJson()).toList(),
      'description': description,
    };
  }
}
