// import 'package:flutter/material.dart';
// import 'package:fnapp/screens/home_screen.dart';
// import 'package:fnapp/screens/login_screen.dart';
// import 'package:fnapp/providers/user_provider.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkUserAuthentication();
//   }

//   // Check if user is authenticated or logged in
//   Future<void> _checkUserAuthentication() async {
//     // Simulate a delay for the splash screen
//     await Future.delayed(const Duration(seconds: 2));

//     // Assuming we store the user's token or userId in UserProvider
//     final userProvider = Provider.of<UserProvider>(context, listen: false);

//     if (userProvider.userId.isNotEmpty) {
//       // If user is logged in, navigate to home screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     } else {
//       // If user is not logged in, navigate to login screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset('assets/splash_logo.png'), // Your splash logo
//       ),
//     );
//   }
// }
