import 'package:flutter/material.dart';
import 'package:fnapp/screens/community_screen.dart';

class DashboardScreen extends StatefulWidget {
  final Map<String, double>? scannedNutrition;
  final double servingSize;
  final Map<String, double> nutritionData;

  const DashboardScreen({
    super.key,
    this.scannedNutrition,
    this.servingSize = 1.0,
    required this.nutritionData,
  });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, String>> foodRecommendations = [];
  DateTime currentDate = DateTime.now();
  Map<String, double> dailyNutrition = {
    'Calories': 0.0,
    'Fat': 0.0,
    'Protein': 0.0,
    'Carbs': 0.0,
  };

  @override
  void initState() {
    super.initState();
    _getFoodRecommendations();
    _updateNutritionData(
        widget.nutritionData); // Update the nutrition data on load
  }

  // Update daily nutrition data when passed from the previous screen
  void _updateNutritionData(Map<String, double> newNutritionData) {
    setState(() {
      dailyNutrition =
          newNutritionData.isNotEmpty ? newNutritionData : dailyNutrition;
    });
    _getFoodRecommendations(); // Re-fetch food recommendations based on updated data
  }

  void _getFoodRecommendations() {
    setState(() {
      foodRecommendations = [];
      if (dailyNutrition['Carbs']! < 100) {
        foodRecommendations.add({
          'name': 'Whole Grain Bread',
          'image': 'assets/images/hq720 (7).jpg',
        });
      }
      if (dailyNutrition['Protein']! < 50) {
        foodRecommendations.add({
          'name': 'Chicken Breast',
          'image': 'assets/images/hq720 (7).jpg',
        });
      }
      if (dailyNutrition['Calories']! < 1200) {
        foodRecommendations.add({
          'name': 'Vegetable Soup',
          'image': 'assets/images/hq720 (7).jpg',
        });
      }
      if (dailyNutrition['Fat']! < 30) {
        foodRecommendations.add({
          'name': 'Avocado Salad',
          'image': 'assets/images/hq720 (7).jpg',
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 21, 107, 9),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Healthy Info Section
              const Text(
                'Healthy Info',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              _buildHealthyInfoCard('BMI', '24.5', Icons.accessibility_new),
              const SizedBox(height: 16),
              _buildHealthyInfoCard('Weight', '70 kg', Icons.fitness_center),
              const SizedBox(height: 16),
              _buildHealthyInfoCard('Sex', 'Male', Icons.accessibility),
              const SizedBox(height: 20),

              // Today's Intake Title
              const Text(
                'Today\'s Intake',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Nutrition Cards Section
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildNutritionCard(
                    index == 0
                        ? 'Calories'
                        : index == 1
                            ? 'Fat'
                            : index == 2
                                ? 'Protein'
                                : 'Carbs',
                    index == 0
                        ? '${dailyNutrition['Calories']}g'
                        : index == 1
                            ? '${dailyNutrition['Fat']}g'
                            : index == 2
                                ? '${dailyNutrition['Protein']}g'
                                : '${dailyNutrition['Carbs']}g',
                    index == 0
                        ? Icons.local_fire_department
                        : index == 1
                            ? Icons.fastfood
                            : index == 2
                                ? Icons.fitness_center
                                : Icons.local_drink,
                    index == 0
                        ? Colors.red
                        : index == 1
                            ? Colors.orange
                            : index == 2
                                ? Colors.green
                                : Colors.blue,
                  );
                },
              ),
              const SizedBox(height: 30),

              // Food Recommendations Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the CommunityScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CommunityScreen(), // Navigate to CommunityScreen
                      ),
                    );
                  },
                  child: const Text('Food Recommendations',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 31, 146, 35),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Breath Animation Image Section
              Center(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 1.0, end: 1.05),
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInOut,
                  onEnd: () {
                    // Reset the animation to start again
                    setState(() {});
                  },
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child:
                          Image.asset('assets/images/app-01.png', height: 200),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Nutrition Card Widget
  Widget _buildNutritionCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 5,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Healthy Info Card Widget
  Widget _buildHealthyInfoCard(String title, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
          size: 30,
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
