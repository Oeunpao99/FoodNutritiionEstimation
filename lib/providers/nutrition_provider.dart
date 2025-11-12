import 'package:flutter/material.dart';

class NutritionProvider with ChangeNotifier {
  // Nutrition data map to hold the values for calories, carbs, fat, protein
  Map<String, double> _nutritionData = {
    'calories': 0.0,
    'carbs': 0.0,
    'fat': 0.0,
    'protein': 0.0,
  };

  Map<String, double> get nutritionData => _nutritionData;

  // Method to update the nutrition data
  void updateNutrition(Map<String, double> newNutritionData) {
    _nutritionData = newNutritionData;
    notifyListeners(); // Notify listeners to rebuild widgets
  }

  void addServing(Map<String, double> selectedNutrition, double servingSize) {
    // Safely access nutrition values with a fallback of 0.0 if null
    _nutritionData['calories'] = (_nutritionData['calories'] ?? 0.0) +
        (selectedNutrition['calories'] ?? 0.0) * servingSize;
    _nutritionData['carbs'] = (_nutritionData['carbs'] ?? 0.0) +
        (selectedNutrition['carbs'] ?? 0.0) * servingSize;
    _nutritionData['fat'] = (_nutritionData['fat'] ?? 0.0) +
        (selectedNutrition['fat'] ?? 0.0) * servingSize;
    _nutritionData['protein'] = (_nutritionData['protein'] ?? 0.0) +
        (selectedNutrition['protein'] ?? 0.0) * servingSize;

    // Notify listeners to update the UI
    notifyListeners();
  }
}
