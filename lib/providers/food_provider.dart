import 'package:flutter/material.dart';
import '../models/food_model.dart';

class FoodProvider with ChangeNotifier {
  final List<Food> _foods = [];

  List<Food> get foods => _foods;

  void addFood(Food food) {
    _foods.add(food);
    notifyListeners();
  }
}
