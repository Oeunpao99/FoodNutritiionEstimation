import 'package:flutter/material.dart';

class ProgressScreens extends StatelessWidget {
  final double calories;
  final double carbs;
  final double fat;
  final double protein;

  ProgressScreens({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein, required int userId, required Map nutritionData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🍽️ Progress")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("🍽️ Your Progress", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text("Calories: $calories kcal", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Carbs: $carbs g", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Fat: $fat g", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Protein: $protein g", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
