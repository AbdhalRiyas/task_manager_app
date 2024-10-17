import '../database/database_service.dart';
import '../models/task.dart';

class TaskRepository {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Task>> getAllTasks() {
    return _databaseService.getTasks();
  }

  Future<int> addTask(Task task) {
    return _databaseService.insertTask(task);
  }

  Future<int> updateTask(Task task) {
    return _databaseService.updateTask(task);
  }

  Future<int> deleteTask(int id) {
    return _databaseService.deleteTask(id);
  }
}
