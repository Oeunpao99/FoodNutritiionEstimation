class User {
  final String userId;
  final String username;
  final String email;

  User({
    required this.userId,
    required this.username,
    required this.email,
  });

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],  // Adjust based on the actual key
      username: json['username'],
      email: json['email'],
    );
  }

  // Method to convert a User instance back to a Map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
    };
  }
}
