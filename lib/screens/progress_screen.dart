import 'package:flutter/material.dart';
import 'package:fnapp/providers/user_provider.dart';
import 'package:fnapp/screens/community_screen.dart';
import 'package:fnapp/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProgressScreen extends StatefulWidget {
  final Map<String, double>? scannedNutrition;
  final double servingSize;

  const ProgressScreen(
      {super.key,
      this.scannedNutrition,
      this.servingSize = 1.0,
      required Map<String, double> nutritionData, required int userId});

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  DateTime currentDate = DateTime.now();
  List<Map<String, dynamic>> progressData = [];

  // Nutrition Limits
  double maxCalories = 2000;
  double maxProtein = 150;
  double maxFat = 70;
  double maxCarbs = 50;

  // Updated Nutrition Data
  double totalCalories = 0;
  double totalProtein = 0;
  double totalFat = 0;
  double totalCarbs = 0;

  @override
  void initState() {
    super.initState();
    _fetchProgressData();
    _updateScannedNutrition();
  }

  void _updateScannedNutrition() {
    if (widget.scannedNutrition != null) {
      setState(() {
        totalCalories +=
            (widget.scannedNutrition!["calories"] ?? 0) * widget.servingSize;
        totalProtein +=
            (widget.scannedNutrition!["protein"] ?? 0) * widget.servingSize;
        totalFat += (widget.scannedNutrition!["fat"] ?? 0) * widget.servingSize;
        totalCarbs +=
            (widget.scannedNutrition!["carbs"] ?? 0) * widget.servingSize;
      });
    }
  }

  Future<void> _fetchProgressData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchUserId(context);
    final int? userId = userProvider.userId;

    if (userId != null) {
      final response = await AuthService().fetchProgressData(userId);
      if (response != null && response['success']) {
        setState(() {
          progressData = List<Map<String, dynamic>>.from(response['data']);
          totalCalories = userProvider.totalCalories;
          totalProtein = userProvider.totalProtein;
          totalFat = userProvider.totalFat;
          totalCarbs = userProvider.totalCarbs;
        });
      }
    }
  }

  void _checkNutritionLimits() {
    if (totalCalories > maxCalories ||
        totalProtein > maxProtein ||
        totalFat > maxFat ||
        totalCarbs > maxCarbs) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNutritionAlert();
      });
    }
  }

  void _showNutritionAlert() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Nutrition Limit Exceeded'),
            content: const Text(
                'You have exceeded daily nutrition limits. Consider adjusting your intake.'),
            actions: <Widget>[
              TextButton(
                child: const Text('View Suggestions'),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CommunityScreen(),
                      ),
                    );
                  }
                },
              ),
              TextButton(
                child: const Text('Continue'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkNutritionLimits();

    return Scaffold(
      appBar: AppBar(title: const Text('Progress Overview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTotalNutritionToday(),
            _buildNutritionStats(),
            _buildCircularProgressIndicators(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommunityScreen()),
                );
              },
              child: const Text('See Added Food'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalNutritionToday() {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Nutrition Intake for Today',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildNutritionalBar(
                'Calories', totalCalories, maxCalories, Colors.red),
            _buildNutritionalBar('Fat', totalFat, maxFat, Colors.green),
            _buildNutritionalBar(
                'Protein', totalProtein, maxProtein, Colors.blue),
            _buildNutritionalBar('Carbs', totalCarbs, maxCarbs, Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionalBar(
      String title, double value, double maxValue, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (value / maxValue).clamp(0.0, 1.0),
          color: color,
          backgroundColor: color.withOpacity(0.3),
        ),
        const SizedBox(height: 8),
        Text('${value.toStringAsFixed(1)}g / ${maxValue.toStringAsFixed(0)}g'),
      ],
    );
  }

  Widget _buildCircularProgressIndicators() {
    return Column(
      children: [
        _buildCircularProgress(
            'Calories', totalCalories, maxCalories, Colors.red),
        _buildCircularProgress('Fat', totalFat, maxFat, Colors.green),
        _buildCircularProgress(
            'Protein', totalProtein, maxProtein, Colors.blue),
        _buildCircularProgress('Carbs', totalCarbs, maxCarbs, Colors.purple),
      ],
    );
  }

  Widget _buildCircularProgress(
      String title, double value, double maxValue, Color color) {
    double progress = (value / maxValue).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 8,
            valueColor: AlwaysStoppedAnimation(color),
            backgroundColor: color.withOpacity(0.3),
          ),
          const SizedBox(height: 8),
          Text('${(progress * 100).toStringAsFixed(1)}%'),
        ],
      ),
    );
  }

  Widget _buildNutritionStats() {
    double proteinProgress = (totalProtein / maxProtein) * 100;
    double caloriesProgress = (totalCalories / maxCalories) * 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Protein Goal: ${proteinProgress.toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 16)),
        Text('Calories Goal: ${caloriesProgress.toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        if (proteinProgress < 80)
          Text('Consider increasing your protein intake!',
              style: TextStyle(color: Colors.red)),
        if (caloriesProgress > 100)
          Text('You have exceeded your calorie intake!',
              style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
