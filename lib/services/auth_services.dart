import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl =
      "http://your-server.com/php-backend"; // Change to your actual backend URL

  // Signup function
  Future<Map<String, dynamic>> signUp(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/signup.php"),
      body: jsonEncode(
          {"username": username, "email": email, "password": password}),
      headers: {"Content-Type": "application/json"},
    );

    return jsonDecode(response.body);
  }

  // Login function
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login.php"),
      body: jsonEncode({"email": email, "password": password}),
      headers: {"Content-Type": "application/json"},
    );

    return jsonDecode(response.body);
  }
}
