import 'package:task_manager_test/data/model/task_model.dart';

abstract class NetworkService {
  Future<List> fetchTasks();
  Future<List> addTask(TaskModel model);
  Future<List> changeTask(String taskId, bool isChecked);
  Future<List> deleteTask(String taskId);
}
