import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl =
      'http://10.0.2.2/php-practics/fnapp/fnapp_backend';

  // 📝 SIGN UP METHOD
  Future<Map<String, dynamic>?> signUp(
      String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/signup.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to sign up'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2/php-practics/fnapp/fnapp_backend/process_login.php'), // Ensure this URL is correct
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          // Save user data in shared preferences for future use
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('username', data['username']);
          prefs.setString('email', data['email']);

          return data; // Return successful login response with user data
        } else {
          return {
            'success': false,
            'message': data['message'] ?? 'Invalid email or password'
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Failed to log in. Please try again.'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // 🧑‍💻 GET USER PROFILE METHOD
  Future<Map<String, dynamic>?> getUserProfile(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/fetch_user_data.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return data;
        } else {
          return {
            'success': false,
            'message': data['message'] ?? 'Failed to fetch user profile'
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch profile. Please try again.'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Future<Map<String, dynamic>?> saveMeal(
  //     String foodName,
  //     int calories,
  //     double fat,
  //     double protein,
  //     double sugar,
  //     double otherSugar,
  //     double servingSize) async {
  //   try {
  //     // Retrieve user ID from SharedPreferences
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     int userId = prefs.getInt('user_id') ?? 0;

  //     if (userId == 0) {
  //       return {'success': false, 'message': 'User not authenticated'};
  //     }

  //     // Get the current date and time for the meal_date
  //     String mealDate =
  //         DateTime.now().toIso8601String(); // Format: 'YYYY-MM-DDTHH:MM:SS'

  //     // Prepare the data to be sent to the backend
  //     final response = await http.post(
  //       Uri.parse('$_baseUrl/insert_meal.php'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'user_id': userId,
  //         'food_name': foodName,
  //         'calories': calories,
  //         'fat': fat,
  //         'protein': protein,
  //         'carbs': sugar,
  //         'serving_size': servingSize,
  //         'meal_date': mealDate, // Add meal_date to the request
  //       }),
  //     );

  //     // Handle response
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       if (responseData['success']) {
  //         return {'success': true, 'message': 'Meal saved successfully'};
  //       } else {
  //         return {
  //           'success': false,
  //           'message': responseData['message'] ?? 'Failed to save meal'
  //         };
  //       }
  //     } else {
  //       return {
  //         'success': false,
  //         'message': 'Failed to save meal. Server error.'
  //       };
  //     }
  //   } catch (e) {
  //     return {'success': false, 'message': 'Error: $e'};
  //   }
  // }

  // 🧑‍💼 GET USER ID BY USERNAME METHOD
  Future<Map<String, dynamic>?> getUserIdByUsername(String username) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/get_user_id_by_username.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return {'success': true, 'id': data['id']};
        } else {
          return {'success': false, 'message': 'User not found'};
        }
      } else {
        return {'success': false, 'message': 'Failed to fetch user ID'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // 🧑‍💻 FETCH PROGRESS RECORDS METHOD
  Future<Map<String, dynamic>?> fetchProgressData(int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/get_progress_data.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          return data;
        } else {
          return {
            'success': false,
            'message': data['message'] ?? 'Failed to fetch progress records'
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch progress records. Please try again.'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // 🛍️ GET SHOPS METHOD
  Future<List<Map<String, String>>> getShops() async {
    final response = await http.get(Uri.parse('$_baseUrl/get_shops.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((shop) {
        return {
          'name': shop['name']?.toString() ?? '',
          'location': shop['location']?.toString() ?? '',
          'contact': shop['contact']?.toString() ?? '',
          'rating': shop['rating']?.toString() ?? '',
          'offer': shop['offer']?.toString() ?? '',
          'productType': shop['productType']?.toString() ?? '',
          'imageUrl': shop['imageUrl']?.toString() ?? '',
        };
      }).toList();
    } else {
      throw Exception('Failed to load shops');
    }
  }
}
