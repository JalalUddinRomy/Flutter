import 'package:get/get.dart';

import '../Data/Models/network_response.dart';
import '../Data/Models/task_list_model.dart';
import '../Data/Models/task_model.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';

class CancelledTaskController extends GetxController{
  bool _inprogress=false;
  String? _errorMessage;
  String? get errorMessage=>_errorMessage;
  List<TaskModel> _getCancelledTaskList = [];
  List<TaskModel> get  CancelledTaskList=>_getCancelledTaskList;
  bool get inprogress=>_inprogress;
  Future<bool> getCancelledTaskItem() async {
    bool isSuccess=false;
    _getCancelledTaskList.clear();
    _inprogress= true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.cancelledTask,
    );
    if (response.isSuccessful) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _getCancelledTaskList = taskListModel.taskList ?? [];
      isSuccess=true;
    } else {
      _errorMessage=response.errorMessage;
    }
   _inprogress=false;
    update();
    return isSuccess;
  }
}