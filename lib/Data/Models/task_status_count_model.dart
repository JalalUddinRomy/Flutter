import 'package:todo_app/Data/Models/task_status_count.dart' show TaskCountModel;

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
