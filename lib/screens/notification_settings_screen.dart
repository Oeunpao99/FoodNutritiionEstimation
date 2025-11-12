import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Enable Notifications:',
              style: TextStyle(fontSize: 18),
            ),
            Switch(
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                // You can handle saving the user's preference here
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the notification preference, perhaps in UserProvider
                // For now, we will just show a message.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        _notificationsEnabled
                            ? 'Notifications Enabled'
                            : 'Notifications Disabled',
                    ),
                  ),
                );
                Navigator.pop(context); // Go back to Profile screen
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
