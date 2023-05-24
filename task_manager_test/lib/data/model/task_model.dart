/// id : "1303"
/// taskId : "[#df9dc]"
/// status : 1
/// name : "Назва "
/// type : 1
/// description : "qwe"
/// file : ""
/// finishDate : "2023-05-04"
/// urgent : 0
/// syncTime : "2023-05-22 21:57:33"

class TaskModel {
  final String id;
  final String taskId;
  final num? status;
  final String? name;
  final num? type;
  final String? description;
  final String? file;
  final String? finishDate;
  final num? urgent;
  final String? syncTime;

  const TaskModel({
    required this.id,
    required this.taskId,
    required this.status,
    required this.name,
    required this.type,
    required this.description,
    required this.file,
    required this.finishDate,
    required this.urgent,
    required this.syncTime,
  });

  factory TaskModel.fromJson(dynamic json) {
    final id = json['id'];
    final taskId = json['taskId'];
    final status = json['status'];
    final name = json['name'];
    final type = json['type'];
    final description = json['description'];
    final file = json['file'];
    final finishDate = json['finishDate'];
    final urgent = json['urgent'];
    final syncTime = json['syncTime'];
    return TaskModel(
      id: id,
      taskId: taskId,
      status: status,
      name: name,
      type: type,
      description: description,
      file: file,
      finishDate: finishDate,
      urgent: urgent,
      syncTime: syncTime,
    );
  }

  TaskModel copyWith({
    String? id,
    String? taskId,
    num? status,
    String? name,
    num? type,
    String? description,
    String? file,
    String? finishDate,
    num? urgent,
    String? syncTime,
  }) =>
      TaskModel(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        status: status ?? this.status,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
        file: file ?? this.file,
        finishDate: finishDate ?? this.finishDate,
        urgent: urgent ?? this.urgent,
        syncTime: syncTime ?? this.syncTime,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['taskId'] = taskId;
    map['status'] = status;
    map['name'] = name;
    map['type'] = type;
    map['description'] = description;
    map['file'] = file;
    map['finishDate'] = finishDate;
    map['urgent'] = urgent;
    map['syncTime'] = syncTime;
    return map;
  }
}
