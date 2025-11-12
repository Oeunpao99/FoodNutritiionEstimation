import 'package:flutter/material.dart';
import '../models/community_model.dart';

class CommunityProvider with ChangeNotifier {
  final List<CommunityPost> _posts = [];

  List<CommunityPost> get posts => _posts;

  void addPost(CommunityPost post) {
    _posts.add(post);
    notifyListeners();
  }
}
