import 'package:flutter/material.dart';
import 'package:fnapp/providers/nutrition_provider.dart';
import 'package:fnapp/providers/user_provider.dart';
import 'package:fnapp/screens/home_screen.dart';
import 'package:fnapp/screens/login_screen.dart';
import 'package:fnapp/screens/signup_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => NutritionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health & Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
      home: Consumer<UserProvider>(  // Using Consumer to access UserProvider
        builder: (context, userProvider, child) {
          // Navigate to HomeScreen if the user is logged in, otherwise show WelcomeScreen
          return userProvider.userName.isNotEmpty
              ? HomeScreen(userEmail: userProvider.userEmail, username: userProvider.userName, email: '',)
              : const WelcomeScreen();
        },
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to FoodTracker!',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 15, 103, 10),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BreathingLogo(),
              const SizedBox(height: 40),

              const Text(
                'Track your food, stay healthy, and achieve your goals!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 10, 13, 102),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  icon: const Icon(Icons.person_add, size: 18),
                  label: const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 51, 120, 74), // A fresh green
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  icon: const Icon(Icons.login, size: 18),
                  label: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 241, 150, 14), // A deep blue
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Call to Action: Healthy Eating
              IconButton(
                icon: const Icon(Icons.restaurant_menu,
                    size: 50, color: Colors.green),
                onPressed: () {
                  // Navigate to the food suggestion screen or community section
                },
              ),
              const Text(
                'Healthy Eating Starts Here!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 34, 45, 24),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Breathing Logo Widget
class BreathingLogo extends StatefulWidget {
  const BreathingLogo({super.key});

  @override
  _BreathingLogoState createState() => _BreathingLogoState();
}

class _BreathingLogoState extends State<BreathingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Image.asset(
        'assets/images/logo-01.png',
        height: 150,
      ),
    );
  }
}
