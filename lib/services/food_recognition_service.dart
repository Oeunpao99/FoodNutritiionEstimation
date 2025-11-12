// import 'package:http/http.dart' as http;

// class FoodRecognitionService {
//   final String apiUrl;

//   FoodRecognitionService(this.apiUrl);

//   Future<String> recognizeFood(String imagePath) async {
//     // Call an API to recognize food
//     var response = await http.post(
//       Uri.parse('$apiUrl/recognize'),
//       body: {'image': imagePath},
//     );

//     if (response.statusCode == 200) {
//       return response.body; // Process response
//     } else {
//       throw Exception('Failed to recognize food');
//     }
//   }
// }
