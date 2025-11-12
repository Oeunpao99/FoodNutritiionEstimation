import 'package:flutter/material.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  // Map to track meal completion
  final Map<String, bool> mealStatus = {
    'Breakfast: Avocado Toast': false,
    'Lunch: Grilled Chicken Salad': false,
    'Dinner: Quinoa and Vegetables': false,
  };

  // Message to show when meal is marked as done
  String rewardMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personalized Meal Plan',
          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 12, 134, 39),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Here is your Meal Plan for Today:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Meal Plan Items
            _buildMealTile('Breakfast: Avocado Toast', '300 kcal'),
            _buildMealTile('Lunch: Grilled Chicken Salad', '450 kcal'),
            _buildMealTile('Dinner: Quinoa and Vegetables', '500 kcal'),
            const SizedBox(height: 20),
            // Reward Message Display
            if (rewardMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  rewardMessage,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealTile(String meal, String calories) {
    bool isCompleted = mealStatus[meal] ?? false;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Icon(
          Icons.fastfood,
          color: const Color.fromARGB(255, 10, 146, 55),
          size: 30,
        ),
        title: Text(
          meal,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isCompleted ? Colors.green : Colors.black,
          ),
        ),
        subtitle: Text(
          'Calories: $calories',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: isCompleted
            ? Icon(
                Icons.check_circle,
                color: const Color.fromARGB(255, 21, 108, 24),
                size: 30,
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 12, 115, 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                onPressed: () {
                  setState(() {
                    mealStatus[meal] = true; // Mark as completed
                    rewardMessage =
                        'You added $meal, earning a reward for healthy eating!';
                  });
                },
                child: const Text(
                  'Mark as Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
