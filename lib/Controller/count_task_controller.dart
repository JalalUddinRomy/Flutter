import 'package:get/get.dart';
import 'package:task_manager_getx/Data/Models/task_status_count.dart';

import '../Data/Models/network_response.dart';
import '../Data/Models/task_status_count_model.dart';
import '../Data/Services/network_caller.dart';
import '../Data/Utils/urls.dart';

class CountTaskController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;
  bool get inProgress=>_inProgress;
  String? get errorMessage=>_errorMessage;
  List<TaskCountModel> _taskCount=[];
  List<TaskCountModel> get taskcount=>_taskCount;
  Future<bool> getCountTaskItem() async{
    bool isSuccess=false;
    _taskCount.clear();
    _inProgress=true;
    update();
    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.countTask);
    if(response.isSuccessful){
      final TaskStatusCount taskStatusCount=TaskStatusCount.fromJson(response.responseData);
      _taskCount=taskStatusCount.taskStatusCountList ?? [];
      isSuccess=true;
    }else{
     _errorMessage=response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}