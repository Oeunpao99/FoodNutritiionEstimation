// import 'dart:convert';

// import 'package:flutter/material.dart';
// // For food recognition API

// class FoodRecommendationScreen extends StatefulWidget {
//   final String preference; // This will be passed (e.g., 'Gym Enthusiasts')

//   const FoodRecommendationScreen({Key? key, required this.preference})
//       : super(key: key);

//   @override
//   _FoodRecommendationScreenState createState() =>
//       _FoodRecommendationScreenState();
// }

// class _FoodRecommendationScreenState extends State<FoodRecommendationScreen> {
//   List<dynamic> foodList = [];
//   bool isLoading = true;

//   get http => null;

//   @override
//   void initState() {
//     super.initState();
//     _fetchFoodRecommendations();
//   }

//   // Fetch food recommendations based on the user preference
//   Future<void> _fetchFoodRecommendations() async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//             'http://10.0.2.2/php-practics/fnapp/fnapp_backend/food_recommend.php'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'preference': widget.preference}),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['success']) {
//           setState(() {
//             foodList = data['foods'];
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             isLoading = false;
//           });
//           _showErrorSnackbar(data['message']);
//         }
//       } else {
//         _showErrorSnackbar('Failed to load food recommendations');
//       }
//     } catch (e) {
//       _showErrorSnackbar('Error: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Function to show error messages
//   void _showErrorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Food Recommendations'),
//         backgroundColor: const Color.fromARGB(255, 231, 83, 132),
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : foodList.isEmpty
//               ? const Center(child: Text('No food recommendations available'))
//               : _buildFoodList(),
//     );
//   }

//   // Build a list of food items based on the recommendations
//   Widget _buildFoodList() {
//     return ListView.builder(
//       itemCount: foodList.length,
//       itemBuilder: (context, index) {
//         final food = foodList[index];
//         return _buildFoodCard(food);
//       },
//     );
//   }

//   // Build individual food card
//   Widget _buildFoodCard(dynamic food) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       elevation: 8,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: ListTile(
//         leading: food['image_url'] != null
//             ? Image.network(food['image_url'], width: 50, height: 50)
//             : const Icon(Icons.food_bank, color: Colors.green),
//         title: Text(food['name'],
//             style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(
//             'Protein: ${food['protein_content']}g ${food['is_vegan'] ? 'Vegan' : ''}'),
//         onTap: () {
//           // You can add further details or actions here if necessary
//         },
//       ),
//     );
//   }
// }
