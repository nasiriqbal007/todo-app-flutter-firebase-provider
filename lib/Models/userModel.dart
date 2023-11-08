// ignore_for_file: file_names

class UserModel {
  final String userId;
  final String username;
  final String phoneNumber;
  final String email;

  UserModel({
    required this.userId,
    required this.username,
    required this.phoneNumber,
    required this.email,
  });

  // Convert UserModel object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  // Factory method to create a UserModel object from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }
}
