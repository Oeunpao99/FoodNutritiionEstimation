import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final String userEmail;

  const ProfileScreen({super.key, required this.userEmail});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2/php-practics/fnapp/fnapp_backend/get_user_profile.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': widget.userEmail}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            userData = data['user'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          _showErrorSnackbar(data['message']);
        }
      } else {
        _showErrorSnackbar(
            'Failed to load profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      _showErrorSnackbar('An error occurred: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to show error messages
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 231, 83, 132),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text('No data available'))
              : _buildProfileContent(),
    );
  }

  Widget _buildProfileContent() {
    if (userData == null) {
      return const Center(
        child: Text(
          'No user data found',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Profile Image
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/profile_placeholder.png"),
          ),
          const SizedBox(height: 10),
          // Display Registered Username
          Text(
            userData!['username'],
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 5),
          // Display Registered Email
          Text(
            userData!['email'],
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          // Display Profile Options
          _buildProfileCard("Joined Date", userData!['created_at']),
          _buildProfileCard("Edit Profile", "Change your info"),
          _buildProfileCard("Settings", "Manage your preferences"),
          _buildProfileCard("Logout", "Sign out of your account"),
        ],
      ),
    );
  }

  // Build a reusable card for profile options
  Widget _buildProfileCard(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: _getIconForTitle(title),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {
          // Handle click actions later (e.g., navigate to Edit Profile)
        },
      ),
    );
  }

  // Get the appropriate icon for each card
  Icon _getIconForTitle(String title) {
    switch (title) {
      case "Edit Profile":
        return const Icon(Icons.edit, color: Colors.blue);
      case "Settings":
        return const Icon(Icons.settings, color: Colors.orange);
      case "Logout":
        return const Icon(Icons.logout, color: Colors.red);
      default:
        return const Icon(Icons.calendar_today, color: Colors.green);
    }
  }
}
