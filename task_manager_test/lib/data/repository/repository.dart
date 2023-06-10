import 'package:task_manager_test/data/model/task_model.dart';

abstract class Repository{
  Future<List<TaskModel>> fetchTasks();
  Future<void> addTask(TaskModel model);
  Future<void> changeTask(int taskId, bool isChecked);
  Future<void> deleteTask(int taskId);
}