import 'package:flutter/material.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository = TaskRepository();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _taskRepository.getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _taskRepository.addTask(task);
    fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await _taskRepository.updateTask(task);
    fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await _taskRepository.deleteTask(id);
    fetchTasks();
  }
}
