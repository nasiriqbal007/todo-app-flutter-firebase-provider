import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/taskModel.dart';

class TaskServices {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getTaskStream(
    String userId,
  ) {
    return _tasksCollection
        .where(
          'userId',
          isEqualTo: userId,
        )
        .snapshots();
  }

  Future<void> addTask(Task task) async {
    task.userId = _auth.currentUser!.uid;
    await _tasksCollection.doc(task.id).set(task.toJson());
  }

  Future<Task?> getTask(String userId, String taskId, String category) async {
    DocumentSnapshot snapshot = await _tasksCollection.doc(taskId).get();
    if (snapshot.exists) {
      Task task = Task.fromJson(snapshot.data() as Map<String, dynamic>);
      if (task.userId == userId) {
        return task;
      }
    }
    return null;
  }

  Future<List<Task>> searchTasksByParameter(
    String userId, {
    String? title,
  }) async {
    Query query = _tasksCollection.where('userId', isEqualTo: userId);

    if (title != null) {
      query = query.where('title', isEqualTo: title);
    }

    QuerySnapshot snapshot = await query.get();
    return snapshot.docs
        .map((doc) => Task.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateTask(Task task) async {
    if (task.userId == _auth.currentUser!.uid) {
      await _tasksCollection.doc(task.id).update(task.toJson());
    } else {
      throw Exception('User does not have permission to update this task');
    }
  }

  Future<void> deleteTask(String taskId, String userId, String category) async {
    final existingTask = await getTask(userId, taskId, category);
    if (existingTask != null && existingTask.userId == _auth.currentUser!.uid) {
      await _tasksCollection.doc(taskId).delete();
    } else {
      throw Exception(
          'Task not found or user does not have permission to delete this task');
    }
  }
}
