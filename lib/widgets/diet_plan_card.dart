import 'package:flutter/material.dart';
import '../models/diet_plan_model.dart';

class DietPlanCard extends StatelessWidget {
  final DietPlan dietPlan;

  const DietPlanCard({super.key, required this.dietPlan});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(dietPlan.name),
        subtitle: Text(dietPlan.description),
      ),
    );
  }
}
