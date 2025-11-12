// import 'package:flutter/material.dart';
// import 'package:fnapp/providers/user_provider.dart';
// import 'package:fnapp/services/auth_service.dart';
// import 'package:provider/provider.dart';

// class FoodDetailScreen extends StatelessWidget {
//   final String name;
//   final String description;
//   final int calories;
//   final double fat;
//   final double protein;
//   final double sugar;
//   final String imageUrl;

//   const FoodDetailScreen({
//     super.key,
//     required this.name,
//     required this.description,
//     required this.calories,
//     required this.fat,
//     required this.protein,
//     required this.sugar,
//     required this.imageUrl,
//     required Null Function(
//             double calories, double fat, double protein, double sugar)
//         onAddToPlan, required double carbs,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: const Color.fromARGB(255, 236, 86, 159),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 250,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   image: DecorationImage(
//                     image: NetworkImage(imageUrl),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 name,
//                 style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 description,
//                 style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black54),
//               ),
//               const SizedBox(height: 20),
//               _buildInfoSection(
//                 icon: Icons.fastfood,
//                 label: 'Calories',
//                 value: '$calories kcal',
//                 context: context,
//               ),
//               const SizedBox(height: 15),
//               _buildInfoSection(
//                 icon: Icons.favorite,
//                 label: 'Fat Content',
//                 value: '${fat.toStringAsFixed(1)} g',
//                 context: context,
//               ),
//               const SizedBox(height: 15),
//               _buildInfoSection(
//                 icon: Icons.local_dining,
//                 label: 'Protein Content',
//                 value: '${protein.toStringAsFixed(1)} g',
//                 context: context,
//               ),
//               const SizedBox(height: 15),
//               _buildInfoSection(
//                 icon: Icons.local_drink,
//                 label: 'Sugar Content',
//                 value: '${sugar.toStringAsFixed(1)} g',
//                 context: context,
//               ),
//               const SizedBox(height: 30),
//               const Text(
//                 'Ingredients:',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(221, 0, 0, 0),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 '• Fresh ingredients, organic quality\n• Natural flavors and colors\n• No artificial preservatives',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black54),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   final userProvider =
//                       Provider.of<UserProvider>(context, listen: false);
//                   userProvider.addToPlan(
//                       calories.toDouble(), fat, protein, sugar);

//                   // Save meal data to backend
//                   await _saveMealToDatabase(
//                     context,
//                     calories.toDouble(),
//                     fat,
//                     protein,
//                     sugar,
//                   );

//                   // Show confirmation message
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Food added to your plan!')),
//                   );

//                   // Navigate back
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 236, 86, 159),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: const Text(
//                   'Add to My Plan',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoSection({
//     required IconData icon,
//     required String label,
//     required String value,
//     required BuildContext context,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.blueAccent.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             color: Colors.blueAccent,
//             size: 30,
//           ),
//           const SizedBox(width: 12),
//           Text(
//             label,
//             style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87),
//           ),
//           const Spacer(),
//           Text(
//             value,
//             style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _saveMealToDatabase(BuildContext context, double calories,
//       double fat, double protein, double sugar) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);

//     // Fetch user ID from UserProvider
//     await userProvider.fetchUserId(context);
//     final int? id = userProvider.userId; // Use `userId` from UserProvider

//     if (id == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to fetch user data.')),
//       );
//       return;
//     }

//     try {
//       // Save meal to database
//       final response = await AuthService().saveMeal(
//         id.toString(), // ID should be passed as a string (since AuthService expects it as string).
//         name as int, // Directly pass `name` as String
//         calories, // Pass `calories` as double (no need to convert it)
//         fat, // Fat as double
//         protein, // Protein as double
//         sugar, // Sugar as double
//       );

//       if (response != null && response['success']) {
//         print('Meal saved successfully');
//       } else {
//         throw Exception('Failed to save meal');
//       }
//     } catch (e) {
//       print('Error saving meal: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Failed to save the meal. Please try again.')),
//       );
//     }
//   }
// }
