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
  Future<void> addTask(TaskModel model) {
    return networkService.addTask(model);
  }

  @override
  Future<void> changeTask(int taskId, bool isChecked) {
    return networkService.changeTask(taskId, isChecked);
  }

  @override
  Future<void> deleteTask(int taskId) {
    return networkService.deleteTask(taskId);
  }
}
