// ignore_for_file: file_names

class Task {
  String id;
  String userId;
  String title;
  String description;

  String category;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
  });

  // Convert Task object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'category': category,
    };
  }

  // Factory method to create a Task object from a JSON map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
    );
  }
}
