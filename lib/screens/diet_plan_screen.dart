import 'package:flutter/material.dart';

class DietPlanScreen extends StatelessWidget {
  const DietPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diet Plan')),
      body: Center(child: Text('Diet plans here')),
    );
  }
}
