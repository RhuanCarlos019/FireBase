import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTodo(String task, String userId) async {
    await _firestore.collection('todos').add({
      'task': task,
      'userId': userId,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getTodos() {
    return _firestore.collection('todos').orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> deleteTodo(String taskId) async {
    await _firestore.collection('todos').doc(taskId).delete();
  }
}
