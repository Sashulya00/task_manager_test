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
  final int? status;
  final String? name;
  final int? type;
  final String? description;
  final String? file;
  final DateTime? finishDate;
  final int? urgent;
  final DateTime? syncTime;

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
    final finishDate = DateTime.parse(json['finishDate']);
    final urgent = json['urgent'];
    final syncTime = DateTime.parse(json['syncTime']);
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
    int? status,
    String? name,
    int? type,
    String? description,
    String? file,
    DateTime? finishDate,
    int? urgent,
    DateTime? syncTime,
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
    if (finishDate != null) map['finishDate'] = finishDate!.toIso8601String();
    map['urgent'] = urgent;
    if (syncTime != null) map['syncTime'] = syncTime!.toIso8601String();
    return map;
  }
}
