import 'package:flutter/material.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track Your Habits',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Your Habits for the Day',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // List of habits or habit tracking widgets can be added here
            _buildHabitTile('Drink Water', Icons.local_drink),
            _buildHabitTile('Morning Exercise', Icons.fitness_center),
            _buildHabitTile('Eat Healthy', Icons.fastfood),
            // More habit items can be added as needed
          ],
        ),
      ),
    );
  }

  Widget _buildHabitTile(String habit, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(
        habit,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.check_circle_outline),
        onPressed: () {
          // Implement the logic for marking the habit as completed
        },
      ),
    );
  }
}
