import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:task_manager_test/data/model/task_model.dart';
import 'package:task_manager_test/data/services/network_services.dart';

class NetworkServiceImpl implements NetworkService {
  static const _baseUrl = "https://to-do.softwars.com.ua";
  static const _apiUrl = "$_baseUrl/tasks/";

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
  Future<List> addTask(TaskModel model) async {
    final data = model.toJson();
    final url = Uri.parse(_apiUrl);
    final response = await post(url, body: jsonEncode([data]));
    final responseMap = json.decode(response.body) as Map<String, dynamic>;
    final listMap = List.from(responseMap[_dataKey]);
    return listMap;
  }

  @override
  Future<List> changeTask(String taskId, bool isChecked) async {
    final data = {"status": isChecked ? 2 : 1};
    final response = await put(
      Uri.parse('$_apiUrl$taskId'),
      body: jsonEncode(data),
    );
    final responseMap = json.decode(response.body) as Map<String, dynamic>;
    final listMap = List.from(responseMap[_dataKey]);
    return listMap;
  }

  @override
  Future<List> deleteTask(String taskId) async {
    final data = {"taskId": taskId};
    final response = await delete(
      Uri.parse('$_apiUrl$taskId'),
      body: jsonEncode(data),
    );
    final responseMap = json.decode(response.body) as Map<String, dynamic>;
    final listMap = List.from(responseMap[_dataKey]);
    return listMap;
  }
}
