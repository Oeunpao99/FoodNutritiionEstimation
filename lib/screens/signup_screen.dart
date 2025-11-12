import 'package:flutter/material.dart';
import 'package:fnapp/screens/home_screen.dart'; // Import HomeScreen
import 'package:fnapp/screens/login_screen.dart'; // Import LoginScreen
import 'package:fnapp/services/auth_service.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
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
                'Create a new account',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 33, 33)),
              ),
              const SizedBox(height: 30),

              // Username Input
              _buildInputField(
                context,
                controller: userNameController,
                label: 'Username',
                hint: 'Enter Username',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),

              // Email Input
              _buildInputField(
                context,
                controller: emailController,
                label: 'Email',
                hint: 'Enter Email',
                icon: Icons.email,
              ),
              const SizedBox(height: 20),

              // Password Input
              _buildInputField(
                context,
                controller: passwordController,
                label: 'Password',
                hint: 'Enter Password',
                obscureText: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 30),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    String username = userNameController.text.trim();
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (username.isNotEmpty &&
                        email.isNotEmpty &&
                        password.isNotEmpty) {
                      var response =
                          await AuthService().signUp(username, email, password);

                      if (response != null && response['success'] == true) {
                        // After successful sign up, navigate to HomeScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              userEmail: email,
                              username: username,
                              email: email, // Pass the email to HomeScreen
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
                    backgroundColor: const Color.fromARGB(255, 3, 123, 11),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Google Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Call Google Sign Up method here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 219, 159, 7),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  icon: const Icon(Icons.email, color: Colors.white),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Apple ID Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Call Apple ID Sign Up method here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 19, 202, 46),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  icon: const Icon(Icons.apple, color: Colors.white),
                  label: const Text(
                    'Continue with Apple ID',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Already have an account? Login button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to Login Screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 4, 135, 34),
                      ),
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

  // Custom input field builder with icon
  Widget _buildInputField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Floating label design with icon
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color.fromARGB(255, 22, 116, 4)),
            labelText: label,
            hintText: hint,
            labelStyle: const TextStyle(color: Color.fromARGB(255, 2, 52, 108)),
            hintStyle: const TextStyle(color: Color.fromARGB(255, 30, 233, 81)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    );
  }
}
