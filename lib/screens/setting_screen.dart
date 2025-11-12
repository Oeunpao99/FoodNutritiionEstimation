import 'package:flutter/material.dart';
import 'package:fnapp/screens/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const Text(
              'General Settings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Theme Switcher
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: false, // You can manage state here to toggle dark mode
                onChanged: (bool value) {
                  // Implement dark mode functionality here
                },
              ),
            ),

            const Divider(),

            // Notification Settings
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: Switch(
                value: true, // You can manage state for notifications
                onChanged: (bool value) {
                  // Implement notification toggle functionality here
                },
              ),
            ),

            const Divider(),

            // Language Settings
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              onTap: () {
                // Navigate to language settings or show language options
              },
            ),

            const Divider(),

            // About Us Button
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                // Navigate to About Us screen
              },
            ),

            const Divider(),

            // Privacy Policy Button
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Privacy Policy'),
              onTap: () {
                // Navigate to Privacy Policy screen
              },
            ),

            const Divider(),

            // Logout Button
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout logic here, e.g., clear session and navigate to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
