import 'package:get/get.dart';

import '../Data/Models/network_response.dart';
import '../Data/Models/task_list_model.dart';
import '../Data/Models/task_model.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';

class CompleteTaskController extends GetxController{
  bool _inprogress=false;
  String? _errorMessage;
  String? get errorMessage=>_errorMessage;
  List<TaskModel> _getCompletedTaskList = [];
  List<TaskModel> get  CompletedTaskList=>_getCompletedTaskList;
  bool get inprogress=>_inprogress;
  Future<bool> getCompletedTaskItem() async {
    bool isSuccess=false;
    _getCompletedTaskList.clear();
    _inprogress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.completedTask,
    );
    if (response.isSuccessful) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _getCompletedTaskList = taskListModel.taskList ?? [];
      isSuccess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
    _inprogress=false;
    update();
    return isSuccess;
  }
}