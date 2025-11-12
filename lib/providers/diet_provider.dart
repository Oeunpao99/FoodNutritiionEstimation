import 'package:flutter/material.dart';
import '../models/diet_plan_model.dart';

class DietProvider with ChangeNotifier {
  final List<DietPlan> _dietPlans = [];

  List<DietPlan> get dietPlans => _dietPlans;

  void addDietPlan(DietPlan dietPlan) {
    _dietPlans.add(dietPlan);
    notifyListeners();
  }
}
