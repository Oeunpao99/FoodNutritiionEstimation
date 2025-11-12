import 'package:flutter/material.dart';

class FoodRecommendationScreen extends StatelessWidget {
  final String preference;

  FoodRecommendationScreen({Key? key, required this.preference})
      : super(key: key);

  final List<FoodItem> foodItems = [
    FoodItem(
      id: '1',
      name: 'Apples',
      description: 'Fresh and healthy',
      price: 1.0,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv4oa50thRja2jSt7-nwqbxtsDXAjVZSAp0A&s',
      calories: 95,
      category: 'vegan',
    ),
    FoodItem(
      id: '2',
      name: 'Banana',
      description: 'Rich in potassium',
      price: 0.5,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv4oa50thRja2jSt7-nwqbxtsDXAjVZSAp0A&s',
      calories: 105,
      category: 'vegan',
    ),
    FoodItem(
      id: '3',
      name: 'Chicken Breast',
      description: 'High-protein food',
      price: 2.0,
      imageUrl:
          'https://cdn.britannica.com/36/123536-050-95CB0C6E/Variety-fruits-vegetables.jpg',
      calories: 165,
      category: 'high-protein',
    ),
    FoodItem(
      id: '4',
      name: 'Broccoli',
      description: 'Rich in vitamins and minerals',
      price: 1.5,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8uJlNviYplSX4nB1uQx9OSAyKwpgZm4C_fA&s',
      calories: 55,
      category: 'vegan',
    ),
    FoodItem(
      id: '5',
      name: 'Salmon',
      description: 'Omega-3 rich fish',
      price: 3.0,
      imageUrl:
          'https://www.onceuponachef.com/images/2018/02/pan-seared-salmon--1200x988.jpg',
      calories: 200,
      category: 'sports-nutrition',
    ),
    FoodItem(
      id: '6',
      name: 'Apples',
      description: 'Fresh and healthy',
      price: 1.0,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv4oa50thRja2jSt7-nwqbxtsDXAjVZSAp0A&s',
      calories: 95,
      category: 'vegan',
    ),
    FoodItem(
      id: '7',
      name: 'Banana',
      description: 'Rich in potassium',
      price: 0.5,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv4oa50thRja2jSt7-nwqbxtsDXAjVZSAp0A&s',
      calories: 105,
      category: 'vegan',
    ),
    FoodItem(
      id: '8',
      name: 'Chicken Breast',
      description: 'High-protein food',
      price: 2.0,
      imageUrl:
          'https://cdn.britannica.com/36/123536-050-95CB0C6E/Variety-fruits-vegetables.jpg',
      calories: 165,
      category: 'high-protein',
    ),
    FoodItem(
      id: '9',
      name: 'Broccoli',
      description: 'Rich in vitamins and minerals',
      price: 1.5,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8uJlNviYplSX4nB1uQx9OSAyKwpgZm4C_fA&s',
      calories: 55,
      category: 'vegan',
    ),
    FoodItem(
      id: '10',
      name: 'Salmon',
      description: 'Omega-3 rich fish',
      price: 3.0,
      imageUrl:
          'https://www.onceuponachef.com/images/2018/02/pan-seared-salmon--1200x988.jpg',
      calories: 200,
      category: 'sports-nutrition',
    ),
    FoodItem(
      id: '11',
      name: 'Apples',
      description: 'Fresh and healthy',
      price: 1.0,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv4oa50thRja2jSt7-nwqbxtsDXAjVZSAp0A&s',
      calories: 95,
      category: 'vegan',
    ),
    FoodItem(
      id: '12',
      name: 'Banana',
      description: 'Rich in potassium',
      price: 0.5,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv4oa50thRja2jSt7-nwqbxtsDXAjVZSAp0A&s',
      calories: 105,
      category: 'vegan',
    ),
    FoodItem(
      id: '13',
      name: 'Chicken Breast',
      description: 'High-protein food',
      price: 2.0,
      imageUrl:
          'https://cdn.britannica.com/36/123536-050-95CB0C6E/Variety-fruits-vegetables.jpg',
      calories: 165,
      category: 'high-protein',
    ),
    FoodItem(
      id: '14',
      name: 'Broccoli',
      description: 'Rich in vitamins and minerals',
      price: 1.5,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8uJlNviYplSX4nB1uQx9OSAyKwpgZm4C_fA&s',
      calories: 55,
      category: 'vegan',
    ),
    FoodItem(
      id: '15',
      name: 'Salmon',
      description: 'Omega-3 rich fish',
      price: 3.0,
      imageUrl:
          'https://www.onceuponachef.com/images/2018/02/pan-seared-salmon--1200x988.jpg',
      calories: 200,
      category: 'sports-nutrition',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter food items based on the preference
    List<FoodItem> recommendedFoods =
        foodItems.where((food) => food.category == preference).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food recommendations',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.white,
        backgroundColor:
            const Color.fromARGB(255, 10, 171, 23), // App bar color
      ),
      body: recommendedFoods.isEmpty
          ? Center(
              child: Text(
                'No recommendations for this category yet.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: recommendedFoods.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: FoodCard(foodItem: recommendedFoods[index]),
                );
              },
            ),
    );
  }
}

class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int calories;
  final String category;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.calories,
    required this.category,
  });

  get fat => null;
}

class FoodCard extends StatelessWidget {
  final FoodItem foodItem;

  const FoodCard({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(foodItem.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Food details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodItem.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  foodItem.description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 37, 36, 36),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$${foodItem.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Add food to diet plan functionality
                        _showAddToPlanDialog(context, foodItem);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 232, 84, 134),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text(
                        'Add to Plan',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddToPlanDialog(BuildContext context, FoodItem foodItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Diet Plan'),
          content: Text(
            'Do you want to add ${foodItem.name} to your diet plan?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Here you can implement the logic to add the item to the plan
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${foodItem.name} added to your plan!'),
                  ),
                );
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
