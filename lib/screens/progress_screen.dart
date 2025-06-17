import 'package:flutter/material.dart';
import 'package:todo_app/Data/Models/task_model.dart';
import 'package:todo_app/Data/Utils/urls.dart';
import 'package:todo_app/widgets/center_circular_progress_indicator.dart';

import '../Data/Models/network_response.dart';
import '../Data/Models/task_list_model.dart';
import '../Data/Services/network_caller.dart';
import '../widgets/snackbar_message.dart';
import '../widgets/task_card.dart' show TaskCard;

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<TaskModel> _getProgressList = [];
  bool _getProgressTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProgressTaskItem();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getProgressTaskItem();
      },
      child: Visibility(
        visible: !_getProgressTaskInProgress,
        replacement: CenterCircularProgressIndicator(),
        child: ListView.separated(
          itemCount: _getProgressList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskModel: _getProgressList[index],
              onRefreshLIst: _getProgressTaskItem,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }

  Future<void> _getProgressTaskItem() async {
    _getProgressList.clear();
    _getProgressTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.progressTask,
    );
    if (response.isSuccessful) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _getProgressList = taskListModel.taskList ?? [];
    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }
    _getProgressTaskInProgress = false;
    setState(() {});
  }
}
