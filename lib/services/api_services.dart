// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String baseUrl =
//       "http://localhost/php-practics/fnapp/fnapp_backend/signup.phpd";

//   static Future<Map<String, dynamic>> signUp(
//       String username, String email, String password) async {
//     final response = await http.post(
//       Uri.parse("$baseUrl/signup.php"),
//       body: {
//         "username": username,
//         "email": email,
//         "password": password,
//       },
//     );

//     return json.decode(response.body);
//   }
// }
