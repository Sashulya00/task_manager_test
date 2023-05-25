import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:task_manager_test/data/model/task_model.dart';
import 'package:task_manager_test/data/services/network_services.dart';

class NetworkServiceImpl implements NetworkService {
  static const _baseUrl = "https://to-do.softwars.com.ua";
  static const _apiUrl = "$_baseUrl/tasks";
  static const _addApiUrl = "$_baseUrl/tasks";
  static const _dataKey = 'data';

  @override
  Future<List> fetchTasks() async {
    final url = Uri.parse(_apiUrl);
    final response = await get(url);
    final responseMap = json.decode(response.body) as Map<String, dynamic>;
    final listMap = List.from(responseMap[_dataKey]);
    return listMap;
  }

  @override
  Future<void> addTask(TaskModel model) async {
    final url = Uri.parse(_addApiUrl);
    final response = await post(url,
        body: jsonEncode({
          "taskId": model.id,
          "status": model.status,
          "name": model.name,
          "type": model.type,
          "finishDate": model.finishDate,
          "urgent": model.urgent,
        }));
    if (response.statusCode != 200) throw Exception();
    return;
  }
}
