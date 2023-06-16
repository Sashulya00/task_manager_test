import 'package:task_manager_test/data/model/task_model.dart';

abstract class Repository {
  Future<List<TaskModel>> fetchTasks();
  Future<void> addTask(TaskModel model);
  Future<void> changeTask(String taskId, bool isChecked);
  Future<void> deleteTask(String taskId);
}
