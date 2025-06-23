import 'package:get/get.dart';
import 'package:task_manager_getx/Data/Models/task_model.dart';

import '../Data/Models/network_response.dart';
import '../Data/Models/task_list_model.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';

class NewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<TaskModel> _getTasklist = [];
  List<TaskModel> get getTaskList => _getTasklist;
  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> getNewTaskItem() async {
    bool isSuccess = false;
    _inProgress =true;
    update();
    _getTasklist.clear();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getNewTask);
    if (response.isSuccessful) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
          response.responseData);
      _getTasklist = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}