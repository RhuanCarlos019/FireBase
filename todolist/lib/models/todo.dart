import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String task;
  final String userId;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.task,
    required this.userId,
    required this.createdAt,
  });

  factory Todo.fromDocument(Map<String, dynamic> doc) {
    return Todo(
      id: doc['id'],
      task: doc['task'],
      userId: doc['userId'],
      createdAt: (doc['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'task': task,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}
