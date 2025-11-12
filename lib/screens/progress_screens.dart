import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressScreens extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> nutritionData;

  const ProgressScreens(
      {Key? key, required this.userId, required this.nutritionData})
      : super(key: key);

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreens> {
  List<Map<String, dynamic>> _meals = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _selectedPeriod = 'Daily';
  double totalCalories = 0;
  double totalProtein = 0;
  double totalFat = 0;
  double totalCarbs = 0;

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  Future<void> _fetchMeals() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2/php-practics/fnapp/fnapp_backend/get_meals.php'),
        body: {'user_id': widget.userId, 'period': _selectedPeriod},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          setState(() {
            _meals = data.map((meal) {
              return {
                'id': meal['id'],
                'calories': double.tryParse(meal['calories'].toString()) ?? 0.0,
                'protein': double.tryParse(meal['protein'].toString()) ?? 0.0,
                'fat': double.tryParse(meal['fat'].toString()) ?? 0.0,
                'carbs': double.tryParse(meal['carbs'].toString()) ?? 0.0,
              };
            }).toList();

            // Update total nutrition values
            totalCalories =
                _meals.fold(0, (sum, meal) => sum + meal['calories']);
            totalProtein = _meals.fold(0, (sum, meal) => sum + meal['protein']);
            totalFat = _meals.fold(0, (sum, meal) => sum + meal['fat']);
            totalCarbs = _meals.fold(0, (sum, meal) => sum + meal['carbs']);

            _isLoading = false;
          });
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print('Exception: $e');
    }
  }

  Widget _buildBarChart() {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
      series: <ChartSeries>[
        BarSeries<ChartData, String>(
          dataSource: _meals
              .map((meal) => ChartData("Meal ${meal['id']}", meal['calories']))
              .toList(),
          xValueMapper: (ChartData data, _) => data.mealName,
          yValueMapper: (ChartData data, _) => data.value,
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildMealCard(Map<String, dynamic> meal) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Meal ${meal['id']}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800]),
            ),
            Divider(),
            _buildNutritionRow(Icons.local_dining,
                "Calories: ${meal['calories']} kcal", Colors.green),
            _buildNutritionRow(Icons.fitness_center,
                "Protein: ${meal['protein']} g", Colors.orange),
            _buildNutritionRow(Icons.local_fire_department,
                "Fat: ${meal['fat']} g", Colors.red),
            _buildNutritionRow(
                Icons.car_repair, "Carbs: ${meal['carbs']} g", Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 14, color: color)),
      ],
    );
  }

  Widget _buildTotalNutritionCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Total Nutrition",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800])),
            Divider(),
            _buildNutritionRow(
                Icons.local_dining,
                "Calories: ${totalCalories.toStringAsFixed(0)} kcal",
                Colors.green),
            _buildNutritionRow(Icons.fitness_center,
                "Protein: ${totalProtein.toStringAsFixed(0)} g", Colors.orange),
            _buildNutritionRow(Icons.local_fire_department,
                "Fat: ${totalFat.toStringAsFixed(0)} g", Colors.red),
            _buildNutritionRow(Icons.car_repair,
                "Carbs: ${totalCarbs.toStringAsFixed(0)} g", Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Center(
      child: Text("Failed to load meals. Please try again.",
          style: TextStyle(color: Colors.red, fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meal Progress")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? _buildErrorMessage()
              : Column(
                  children: [
                    _buildTotalNutritionCard(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButton<String>(
                        value: _selectedPeriod,
                        items: ['Daily', 'Weekly', 'Yearly']
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedPeriod = value!;
                            _fetchMeals();
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 200, child: _buildBarChart()),
                    Text("Recent Meals",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[800])),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _meals.length > 3 ? 3 : _meals.length,
                        itemBuilder: (context, index) {
                          return _buildMealCard(_meals[index]);
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

class ChartData {
  final String mealName;
  final double value;

  ChartData(this.mealName, this.value);
}
