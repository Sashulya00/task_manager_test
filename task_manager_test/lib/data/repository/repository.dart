import 'package:task_manager_test/data/model/task_model.dart';

abstract class Repository {
  Future<List<TaskModel>> fetchTasks();
  Future<List<TaskModel>> addTask(TaskModel model);
  Future<List<TaskModel>> changeTask(String taskId, bool isChecked);
  Future<List<TaskModel>> deleteTask(String taskId);
}
