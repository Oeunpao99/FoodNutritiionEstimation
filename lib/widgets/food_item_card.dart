import 'package:flutter/material.dart';
import '../models/food_model.dart';

class FoodItemCard extends StatelessWidget {
  final Food food;

  const FoodItemCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(food.name),
        subtitle: Text('${food.calories} kcal'),
      ),
    );
  }
}
