import 'package:flutter/material.dart';

class FoodSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;

  FoodSearchDelegate({required this.onSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the query
          onSearch(query); // Reset the search results
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // You can leave this empty for now
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Perform search and update the results
    onSearch(query);

    return ListView(
      children: [
        // Example suggestions: Add custom logic to filter and show suggestions
        ListTile(
          title: Text('Salmone Salad'),
          onTap: () {
            query = 'Salmone Salad';
            onSearch(query); // Trigger search for selected food
            close(context, null); // Close the search
          },
        ),
        ListTile(
          title: Text('Soup'),
          onTap: () {
            query = 'Soup';
            onSearch(query);
            close(context, null);
          },
        ),
        ListTile(
          title: Text('Sushi'),
          onTap: () {
            query = 'Sushi';
            onSearch(query);
            close(context, null);
          },
        ),
        ListTile(
          title: Text('Pasta'),
          onTap: () {
            query = 'Pasta';
            onSearch(query);
            close(context, null);
          },
        ),
      ],
    );
  }
}
