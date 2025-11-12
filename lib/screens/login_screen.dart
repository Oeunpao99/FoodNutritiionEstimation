import 'package:flutter/material.dart';
import 'package:fnapp/screens/home_screen.dart'; // Import HomeScreen
// Import SignUpScreen
import 'package:fnapp/screens/signup_screen.dart';
import 'package:fnapp/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false; // For tracking the loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 15, 103, 10),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 33, 33)),
              ),
              const SizedBox(height: 30),

              // Email Input
              _buildInputField(
                controller: emailController,
                label: 'Email',
                hint: 'Enter your email',
              ),
              const SizedBox(height: 20),

              // Password Input
              _buildInputField(
                controller: passwordController,
                label: 'Password',
                hint: 'Enter your password',
                obscureText: true,
              ),
              const SizedBox(height: 30),

              // Login Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null // Disable button while loading
                        : () async {
                            String email = emailController.text
                                .trim(); // Ensure it's not null
                            String password = passwordController.text
                                .trim(); // Ensure it's not null

                            if (email.isNotEmpty && password.isNotEmpty) {
                              setState(() {
                                _isLoading = true; // Start loading
                              });

                              var response =
                                  await AuthService().login(email, password);

                              setState(() {
                                _isLoading = false; // Stop loading
                              });

                              if (response != null &&
                                  response['success'] == true) {
                                // Navigate to HomeScreen after login
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                      username: response[
                                          'username'], // Pass the username
                                      userEmail: response['email'],
                                      email: '', // Pass the email
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(response?['message'] ??
                                        'Unknown error occurred'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('All fields are required')),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 15, 103, 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 33, 33, 33)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 5, 123, 27)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom input field
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, 4)),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }
}
