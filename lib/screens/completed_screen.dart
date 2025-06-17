import 'package:flutter/material.dart';
import 'package:todo_app/Data/Models/task_model.dart';
import 'package:todo_app/Data/Utils/urls.dart';
import 'package:todo_app/widgets/center_circular_progress_indicator.dart';

import '../Data/Models/network_response.dart' show NetworkResponse;
import '../Data/Models/task_list_model.dart' show TaskListModel;
import '../Data/Services/network_caller.dart' show NetworkCaller;
import '../widgets/snackbar_message.dart' show showSnackbarMessage;
import '../widgets/task_card.dart' show TaskCard;

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<TaskModel> _getCompletedTaskList = [];
  bool _getCompletedTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _getCompletedTaskItem();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getCompletedTaskItem();
      },
      child: Visibility(
        visible: !_getCompletedTaskInProgress,
        replacement: CenterCircularProgressIndicator(),
        child: ListView.separated(
          itemCount: _getCompletedTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskModel: _getCompletedTaskList[index],
              onRefreshLIst: _getCompletedTaskItem,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> _getCompletedTaskItem() async {
    _getCompletedTaskList.clear();
    _getCompletedTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.completedTask,
    );
    if (response.isSuccessful) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _getCompletedTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }
    _getCompletedTaskInProgress = false;
    setState(() {});
  }
}
