import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = '';
  String _email = '';

  // Nutrition data fields
  double _totalCalories = 0.0;
  double _totalFat = 0.0;
  double _totalProtein = 0.0;
  double _totalCarbs = 0.0;

  // Getters for user info
  String get userName => _userName;
  String get email => _email;

  // Getters for nutrition data
  double get totalCalories => _totalCalories;
  double get totalFat => _totalFat;
  double get totalProtein => _totalProtein;
  double get totalCarbs => _totalCarbs;

  // Optional: userId can be set or fetched later
  int? get userId => null;
  get userEmail => null;

  // Method to set user data
  void setUser(String userName, String email, response) {
    _userName = userName;
    _email = email;
    // You can also save the response (user data) here if needed
    notifyListeners();
  }
void updateNutrition({
  required double calories,
  required double fat,
  required double protein,
  required double carbs,
}) {
  _totalCalories += calories;
  _totalFat += fat;
  _totalProtein += protein;
  _totalCarbs += carbs;
  notifyListeners();  // Notify listeners to rebuild UI
}



  // Method to update individual nutrition values (optional for more granular control)
  void updateIndividualNutrition({
    double? calories,
    double? fat,
    double? protein,
    double? carbs,
  }) {
    if (calories != null) {
      _totalCalories += calories;
    }
    if (fat != null) {
      _totalFat += fat;
    }
    if (protein != null) {
      _totalProtein += protein;
    }
    if (carbs != null) {
      _totalCarbs += carbs;
    }
    notifyListeners(); // Notify listeners when data is updated
  }

  // Method to select and update specific nutrition values
  void selectedNutrition({
    double? calories,
    double? fat,
    double? protein,
    double? carbs,
  }) {
    if (calories != null) {
      _totalCalories = calories; // Set to the selected value
    }
    if (fat != null) {
      _totalFat = fat; // Set to the selected value
    }
    if (protein != null) {
      _totalProtein = protein; // Set to the selected value
    }
    if (carbs != null) {
      _totalCarbs = carbs; // Set to the selected value
    }
    notifyListeners(); // Notify listeners when data is updated
  }

  // Fetch user ID (for illustration, implement logic based on your backend)
  fetchUserId(BuildContext context) async {
    // Implement your backend logic to fetch user ID
  }

  // Optional: add a method to reset nutrition data at the start of a new day
  void resetNutrition() {
    _totalCalories = 0.0;
    _totalFat = 0.0;
    _totalProtein = 0.0;
    _totalCarbs = 0.0;
    notifyListeners();
  }

  // Optional: method to check nutrition limits and notify if exceeded
  void checkNutritionLimits() {
    double maxCalories = 2500.0; // Example max value, adjust as needed
    double maxFat = 70.0;
    double maxProtein = 150.0;
    double maxCarbs = 100.0;

    if (_totalCalories > maxCalories ||
        _totalFat > maxFat ||
        _totalProtein > maxProtein ||
        _totalCarbs > maxCarbs) {
      // Notify listeners that limits are exceeded (e.g., show a dialog)
      notifyListeners();
    }
  }
}
