class CommunityPost {
  final String id;
  final String userId;
  final String content;
  final DateTime timestamp;

  CommunityPost({
    required this.id,
    required this.userId,
    required this.content,
    required this.timestamp,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    return CommunityPost(
      id: json['id'],
      userId: json['userId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
