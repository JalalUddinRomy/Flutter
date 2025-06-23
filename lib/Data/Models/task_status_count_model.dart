

import 'package:task_manager_getx/Data/Models/task_status_count.dart';

class TaskStatusCount {
  String? status;
  List<TaskCountModel>? taskStatusCountList;

  TaskStatusCount({this.status, this.taskStatusCountList});

  TaskStatusCount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskStatusCountList = <TaskCountModel>[];
      json['data'].forEach((v) {
        taskStatusCountList!.add(TaskCountModel.fromJson(v));
      });
    }
  }
}
