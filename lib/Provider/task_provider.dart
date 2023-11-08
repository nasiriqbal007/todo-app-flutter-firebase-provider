import 'package:flutter/material.dart';

import 'package:todo_app/FirebaseServices/task_services.dart';

import '../Models/taskModel.dart';

class TaskServiceProvider with ChangeNotifier {
  final TaskServices _taskServices = TaskServices();

  TaskServices get taskServices => _taskServices;

  Future<Task?> getTask(String userId, String taskId, String category) async {
    return await _taskServices.getTask(userId, taskId, category);
  }

  Future<List<Task>> searchTasksByTitle(String userId, String title) async {
    return await _taskServices.searchTasksByParameter(userId, title: title);
  }

  Future<void> updateTask(Task task) async {
    await _taskServices.updateTask(task);
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _taskServices.addTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(String taskId, String userId, String categroy) async {
    await _taskServices.deleteTask(taskId, userId, categroy);
    notifyListeners();
  }
}
