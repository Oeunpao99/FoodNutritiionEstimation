import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final String category;

  const CategoryIcon({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(category[0]), // Display the first letter of category
    );
  }
}
