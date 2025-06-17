import 'package:todo_app/Data/Models/task_model.dart' show TaskModel;

class TaskListModel {
  String? status;
  List<TaskModel>? taskList;

  TaskListModel({this.status, this.taskList});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskModel>[];
      json['data'].forEach((v) {
        taskList!.add(TaskModel.fromJson(v));
      });
    }
  }
}
