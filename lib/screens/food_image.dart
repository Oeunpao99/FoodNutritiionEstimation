// import 'package:flutter/material.dart';
// import 'package:fnapp/screens/food_detail_screen.dart'; // Import the FoodDetailScreen

// class FoodItem {
//   final String id;
//   final String name;
//   final String description;
//   final int calories;
//   final double fat;
//   final double protein; // Add protein
//   final double sugar; // Add sugar
//   final String imageUrl;

//   FoodItem({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.calories,
//     required this.fat,
//     required this.protein, // Initialize protein
//     required this.sugar, // Initialize sugar
//     required this.imageUrl,
//   });
// }

// class FoodImageScreen extends StatelessWidget {
//   // Make foodItems static to allow access in other screens
//   static List<FoodItem> foodItems = [
//     FoodItem(
//       id: '1',
//       name: 'Apples',
//       description: 'Fresh and crispy.',
//       calories: 52,
//       fat: 0.2,
//       protein: 0.5, // Example protein value
//       sugar: 10, // Example sugar value
//       imageUrl:
//           'https://w7.pngwing.com/pngs/786/552/png-transparent-platter-of-grilled-lamb-italian-cuisine-pizza-pasta-food-plate-healthy-food-food-beef-roast-beef-thumbnail.png',
//     ),
//     FoodItem(
//       id: '2',
//       name: 'Banana',
//       description: 'Rich in potassium.',
//       calories: 89,
//       fat: 0.3,
//       protein: 1.3, // Example protein value
//       sugar: 12, // Example sugar value
//       imageUrl:
//           'https://w7.pngwing.com/pngs/786/552/png-transparent-platter-of-grilled-lamb-italian-cuisine-pizza-pasta-food-plate-healthy-food-food-beef-roast-beef-thumbnail.png',
//     ),
//     FoodItem(
//       id: '3',
//       name: 'Carrot',
//       description: 'Good for your eyesight.',
//       calories: 41,
//       fat: 0.2,
//       protein: 0.9, // Example protein value
//       sugar: 4, // Example sugar value
//       imageUrl:
//           'https://w7.pngwing.com/pngs/786/552/png-transparent-platter-of-grilled-lamb-italian-cuisine-pizza-pasta-food-plate-healthy-food-food-beef-roast-beef-thumbnail.png',
//     ),
//     FoodItem(
//       id: '4',
//       name: 'Broccoli',
//       description: 'Rich in vitamins.',
//       calories: 55,
//       fat: 0.6,
//       protein: 3.7, // Example protein value
//       sugar: 1.5, // Example sugar value
//       imageUrl:
//           'https://poserworld.com/images/thumbs/0000284_blt-sandwich-food-model-fbx-format.jpeg',
//     ),
//     FoodItem(
//       id: '5',
//       name: 'Strawberry',
//       description: 'Full of antioxidants.',
//       calories: 32,
//       fat: 0.3,
//       protein: 0.8, // Example protein value
//       sugar: 4.5, // Example sugar value
//       imageUrl:
//           'https://poserworld.com/images/thumbs/0000284_blt-sandwich-food-model-fbx-format.jpeg',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: foodItems.length,
//       itemBuilder: (context, index) {
//         return _buildFoodCard(foodItems[index], context);
//       },
//     );
//   }

//   Widget _buildFoodCard(FoodItem food, BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Left side - Image
//           Container(
//             height: 100,
//             width: 100,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               image: DecorationImage(
//                 image: NetworkImage(food.imageUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12), // Space between image and text
//           // Right side - Text and button
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   food.name,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   food.description,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Color.fromARGB(255, 27, 26, 26),
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//                 const SizedBox(height: 8),
//                 // Display calories, fat, protein, and sugar
//                 Text(
//                   'Calories: ${food.calories} kcal\nFat: ${food.fat}g\nProtein: ${food.protein}g\nSugar: ${food.sugar}g',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to the FoodDetailScreen and pass the food details
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FoodDetailScreen(
//                           name: food.name,
//                           description: food.description,
//                           calories: food.calories,
//                           fat: food.fat,
//                           protein: food.protein,
//                           sugar: food.sugar,
//                           imageUrl: food.imageUrl, onAddToPlan: (double , double , double , double ) {  },
//                         ),
//                       ),
//                     );
//                   },
//                   child: const Text('See Details'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
