import 'package:flutter/material.dart';
import 'package:fnapp/screens/food_recommendation_screen.dart';
import 'package:fnapp/services/auth_service.dart'; // Import AuthService

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
 List<Map<String, dynamic>> shops = [];


  @override
  void initState() {
    super.initState();
    _loadShops();
  }

  // Method to load shops from the backend
  Future<void> _loadShops() async {
    try {
      List<Map<String, dynamic>> fetchedShops = await AuthService().getShops();
      setState(() {
        shops = fetchedShops;
      });
    } catch (e) {
      // Handle error (e.g., show an error message)
      print('Error fetching shops: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Community',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 16, 166, 31),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
        child: ListView(
          children: [
            _buildCategoryTitle('Food Suggestions'),
            _buildCommunityCard("Gym Enthusiasts", "Need high-protein foods?",
                context, 'high-protein'),
            _buildCommunityCard("Sports Nutrition",
                "For athletes and fitness lovers", context, 'sports-nutrition'),
            const Divider(thickness: 1, color: Colors.grey),
            _buildCategoryTitle('Local Shops Selling Healthy Products'),
            if (shops.isEmpty)
              const Center(
                  child:
                      CircularProgressIndicator()) // Show loading spinner while shops are being fetched
            else
              ...shops.map((shop) {
                return _buildShopCard(
                  shop['name']!,
                  shop['location']!,
                  shop['contact']!,
                  shop['rating']!,
                  shop['offer']!,
                  shop['productType']!,
                  shop['imageUrl']!,
                  context,
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 10, 13, 102),
        ),
      ),
    );
  }

  Widget _buildCommunityCard(String title, String description,
      BuildContext context, String preference) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color.fromARGB(255, 10, 13, 102),
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
              fontSize: 14, color: Color.fromARGB(255, 5, 5, 5)),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color.fromARGB(255, 10, 13, 102),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FoodRecommendationScreen(preference: preference),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShopCard(
      String name,
      String location,
      String contact,
      String rating,
      String offer,
      String productType,
      String imageUrl,
      BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 10, 13, 102),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.green, size: 15),
                    const SizedBox(width: 5),
                    Text(location, style: const TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.blue, size: 15),
                    const SizedBox(width: 5),
                    Text(contact, style: const TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 15),
                    const SizedBox(width: 5),
                    Text('Rating: $rating',
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.local_offer, color: Colors.red, size: 15),
                    const SizedBox(width: 5),
                    Text('Offer: $offer', style: const TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.fastfood, color: Colors.orange, size: 15),
                    const SizedBox(width: 5),
                    Text('Product Type: $productType',
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                // Implement navigation to shop details screen if needed
              },
            ),
          ),
        ],
      ),
    );
  }
}
