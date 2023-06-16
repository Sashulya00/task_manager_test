import 'package:task_manager_test/data/model/task_model.dart';
import 'package:task_manager_test/data/repository/repository.dart';
import 'package:task_manager_test/data/services/network_services.dart';

class RepositoryImpl implements Repository {
  final NetworkService networkService;

  const RepositoryImpl(this.networkService);

  @override
  Future<List<TaskModel>> fetchTasks() async {
    final listMap = await networkService.fetchTasks();
    final listOfModels = <TaskModel>[];
    for (final json in listMap) {
      listOfModels.add(TaskModel.fromJson(json));
    }
    return listOfModels;
  }

  @override
  Future<List<TaskModel>> addTask(TaskModel model) async {
    final listMap = await networkService.addTask(model);
    final listOfModels = <TaskModel>[];
    for (final json in listMap) {
      listOfModels.add(TaskModel.fromJson(json));
    }
    return listOfModels;
  }

  @override
  Future<List<TaskModel>> changeTask(String taskId, bool isChecked) async {
    final listMap = await networkService.changeTask(taskId, isChecked);
    final listOfModels = <TaskModel>[];
    for (final json in listMap) {
      listOfModels.add(TaskModel.fromJson(json));
    }
    return listOfModels;
  }

  @override
  Future<List<TaskModel>> deleteTask(String taskId) async {
    final listMap = await networkService.deleteTask(taskId);
    final listOfModels = <TaskModel>[];
    for (final json in listMap) {
      listOfModels.add(TaskModel.fromJson(json));
    }
    return listOfModels;
  }
}
