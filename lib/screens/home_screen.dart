import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fnapp/screens/about_screen.dart';
import 'package:fnapp/screens/community_screen.dart';
import 'package:fnapp/screens/dashboard_screen.dart';
import 'package:fnapp/screens/login_screen.dart';
import 'package:fnapp/screens/my_account_screen.dart';
import 'package:fnapp/screens/progress_screens.dart';
import 'package:fnapp/screens/scanning_food.dart';
import 'package:fnapp/screens/setting_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen(
      {super.key,
      required this.userEmail,
      required username,
      required String email});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;
  late String userName;
  late String userProfilePicUrl;

  @override
  void initState() {
    super.initState();
    userName = 'Loading...'; // Default placeholder
    userProfilePicUrl = 'assets/images/9203764.png'; // Default image
    _screens = [
      DashboardScreen(
        nutritionData: {},
      ),
      const ProgressScreens(
        userId: '120',
        nutritionData: {},
      ), // Add a scre
      const CommunityScreen(),
      //en for tracking habits
      // Add a screen for generating personalized meal plans
    ];
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2/php-practics/fnapp/fnapp_backend/fetch_user_data.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': widget.userEmail}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            userName = data['user_name']?.toString() ?? 'User';
            userProfilePicUrl =
                data['profile_pic']?.toString().isNotEmpty == true
                    ? data['profile_pic']
                    : 'assets/images/9203764.png';
          });
        }
      } else {
        _showErrorSnackbar('Failed to load user data');
      }
    } catch (e) {
      _showErrorSnackbar('Error: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _onMenuOptionSelected(int index) {
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AboutScreen()));
        break;
      case 2:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        break;
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Tracking App'), centerTitle: true),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showScanOptionsDialog(context),
        child: const Icon(Icons.camera_alt_outlined),
        backgroundColor: const Color.fromARGB(255, 38, 224, 103),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 21, 160, 37)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(userProfilePicUrl),
                  ),
                  const SizedBox(height: 10),
                  Text(userName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(widget.userEmail,
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('My Account'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAccountScreen(
                      userEmail: widget.userEmail,
                      username: userName,
                      email: widget.userEmail,
                    ),
                  ),
                );
              },
            ),
            ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => _onMenuOptionSelected(0)),
            ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About Us'),
                onTap: () => _onMenuOptionSelected(1)),
            ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () => _onMenuOptionSelected(2)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        unselectedItemColor: const Color.fromARGB(255, 12, 0, 0),
        selectedItemColor: const Color.fromARGB(255, 17, 152, 37),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Recording'),
        
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
        ],
      ),
    );
  }

  void _showScanOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Scan directly'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodRecognitionScreen(
                        scanOption: 'camera', // Pass the 'camera' option
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Upload from Gallery'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodRecognitionScreen(
                        scanOption: 'gallery', // Pass the 'gallery' option
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
