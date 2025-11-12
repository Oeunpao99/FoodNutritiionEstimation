import 'package:http/http.dart' as http;
import 'dart:convert';

class BusinessModel {
  static const String _baseUrl = 'http://localhost/php-practics/fnapp/fnapp_backend';

  // Recommend food based on user needs (e.g., high-protein food)
  Future<Map<String, dynamic>> recommendFoodBasedOnPreferences(String userPreference) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/recommend_food.php'), // API to recommend food
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'preference': userPreference}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'success': false, 'message': 'Failed to fetch food recommendations'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
