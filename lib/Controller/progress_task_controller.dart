import 'package:get/get.dart';

import '../Data/Models/network_response.dart';
import '../Data/Models/task_list_model.dart';
import '../Data/Models/task_model.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';

class ProgressTaskController extends GetxController {
  bool _inprogress = false;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  List<TaskModel> _getProgressList = [];

  List<TaskModel> get ProgressTaskList => _getProgressList;

  bool get inprogress => _inprogress;

  Future<bool> getProgressTaskItem() async {
    bool isSuccess=false;
    _getProgressList.clear();
    _inprogress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.progressTask,
    );
    if (response.isSuccessful) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _getProgressList = taskListModel.taskList ?? [];
      isSuccess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
    _inprogress=false;
    update();
    return isSuccess;
  }
}
