import 'package:flutter/material.dart';
import 'package:todo_app/Data/Utils/urls.dart';
import 'package:todo_app/widgets/center_circular_progress_indicator.dart';

import '../Data/Models/network_response.dart' show NetworkResponse;
import '../Data/Models/task_list_model.dart' show TaskListModel;
import '../Data/Models/task_model.dart';
import '../Data/Services/network_caller.dart' show NetworkCaller;
import '../widgets/snackbar_message.dart' show showSnackbarMessage;
import '../widgets/task_card.dart' show TaskCard;

class CancelledScreen extends StatefulWidget {
  const CancelledScreen({super.key});

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  List<TaskModel> _getCancelledTaskList = [];
  bool _getCancelledTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _getCancelledTaskItem();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getCancelledTaskItem();
      },
      child: Visibility(
        visible: !_getCancelledTaskInProgress,
        replacement: CenterCircularProgressIndicator(),
        child: ListView.separated(
          itemCount: _getCancelledTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskModel: _getCancelledTaskList[index],
              onRefreshLIst: _getCancelledTaskItem,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> _getCancelledTaskItem() async {
    _getCancelledTaskList.clear();
    _getCancelledTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.cancelledTask,
    );
    if (response.isSuccessful) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _getCancelledTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }
    _getCancelledTaskInProgress = false;
    setState(() {});
  }
}
