import 'package:task_manager_test/data/model/task_model.dart';

abstract class NetworkService{
  Future<List> fetchTasks();
  Future<void> addTask(TaskModel model);
}