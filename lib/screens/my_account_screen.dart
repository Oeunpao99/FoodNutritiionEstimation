import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  final String username;
  final String email;

  const MyAccountScreen({
    super.key,
    required this.username,
    required this.email, required String userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Account',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 10, 142, 30),
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(),

              // Account Management Section
              _buildSectionTitle("Account Management"),
              _buildNavigationRow(Icons.edit, "Edit Profile", context,
                  '/edit_profile_screen.dart'),
              _buildNavigationRow(Icons.notifications, "Notifications", context,
                  '/notifications'),
              _buildNavigationRow(Icons.security, "Security Settings", context,
                  '/security_settings'),
              _buildNavigationRow(
                  Icons.link, "Linked Accounts", context, '/linked_accounts'),
              _buildNavigationRow(Icons.subscriptions, "Subscription Plan",
                  context, '/subscription_plan'),

              const SizedBox(height: 30),

              // Track Habits & Rewards Section
              _buildSectionTitle("Track Habits & Rewards"),
              _buildNavigationRow(Icons.track_changes, "Progress Tracking",
                  context, '/progress_tracking'),
              _buildNavigationRow(
                  Icons.card_giftcard, "Rewards", context, '/rewards'),
              _buildNavigationRow(Icons.calendar_today, "Track Habits", context,
                  '/habits_screen'), // New section for HabitsScreen

              const SizedBox(height: 30),

              // AI-based Personalized Meal Plans
              _buildSectionTitle("Personalized Meal Plans"),
              _buildNavigationRow(Icons.restaurant_menu, "Generate Meal Plan",
                  context, '/generate_meal_plan'),
              _buildNavigationRow(Icons.list_alt, "Meal Plan", context,
                  '/meal_plan_screen'), // New section for MealPlanScreen

              const SizedBox(height: 30),

              // Activity & Insights Section
              _buildSectionTitle("Activity & Insights"),
              _buildInfoRow(Icons.bar_chart, "Your Progress",
                  'Health stats, food tracking summary'),
              _buildInfoRow(
                  Icons.fastfood, "Diet Analysis", 'Latest food logs'),
              _buildInfoRow(Icons.group, "Community Activity", '.'),

              const SizedBox(height: 30),

              // Support & Settings Section
              _buildSectionTitle("Support & Settings"),
              _buildInfoRow(
                  Icons.help, "Help & Support", 'FAQ, Contact Support'),
              _buildInfoRow(
                  Icons.privacy_tip, "Privacy & Terms", 'View app policies'),

              const SizedBox(height: 30),

              // Log Out Button
              _buildLogOutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Welcome Section - Center Profile
  Widget _buildWelcomeSection() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
                'assets/images/9203764.png'), // Replace with user's image
          ),
          const SizedBox(height: 10),
          Text(
            'Welcome, $username!',
            style: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const SizedBox(height: 5),
          Text(
            email,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 4, 112, 189),
        ),
      ),
    );
  }

  // Info Row for each menu option
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 217, 145, 2)),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              "$title: $value",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ],
      ),
    );
  }

  // Navigation Row for each section leading to different pages
  Widget _buildNavigationRow(
      IconData icon, String title, BuildContext context, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
              context, route); // Navigate to the respective page
        },
        child: Row(
          children: [
            Icon(icon, color: Colors.pinkAccent),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Log Out Button
  Widget _buildLogOutButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Log out logic here
          _logOut(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 13, 146, 18),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        child: const Text(
          'Log Out',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // Log Out Function
  void _logOut(BuildContext context) {
    // Clear user session, remove authentication token, etc.
    // Then navigate to the login page
    Navigator.pushReplacementNamed(context, '/login');
  }
}
