import 'package:flutter/material.dart';
import '../models/community_model.dart';

class CommunityPostCard extends StatelessWidget {
  final CommunityPost post;

  const CommunityPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.content),
        subtitle: Text('Posted by: ${post.userId} on ${post.timestamp}'),
      ),
    );
  }
}
