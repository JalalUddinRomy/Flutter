import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/Controller/count_task_controller.dart';
import 'package:task_manager_getx/Controller/newTask_controller.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/snackbar_message.dart';
import '../widgets/task_card.dart' show TaskCard;
import '../widgets/task_summary_card.dart' show TaskSummaryCard;
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getNewTaskItem();
    _getCountTaskItem();
  }

  NewTaskController newTaskController = Get.find<NewTaskController>();
  CountTaskController countTaskController = Get.find<CountTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onTapFAB();
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTaskItem();
          _getCountTaskItem();
        },
        child: Column(
          children: [
            _buildSummarySection(),
            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (c) {
                  return Visibility(
                    visible: !c.inProgress,
                    replacement: CenterCircularProgressIndicator(),
                    child: ListView.separated(
                      itemCount: c.getTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskModel: c.getTaskList[index],
                          onRefreshLIst: () {
                            _getNewTaskItem();
                            _getCountTaskItem();
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return GetBuilder<CountTaskController>(
      builder: (controller) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children:
                  controller.taskcount.map((e) {
                    return TaskSummaryCard(title: e.sId!, count: e.sum!);
                  }).toList(),
            ),
          ),
        );
      },
    );
  }

  Future<void> _getNewTaskItem() async {
    final bool result = await newTaskController.getNewTaskItem();
    if (!result) {
      showSnackbarMessage(context, newTaskController.errorMessage!, true);
    }
  }

  Future<void> _getCountTaskItem() async {
    final bool result = await countTaskController.getCountTaskItem();
    if (!result) {
      showSnackbarMessage(context, countTaskController.errorMessage!, true);
    }
  }

  void _onTapFAB() async {
    final bool? _shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );
    if (_shouldRefresh == true) {
      _getNewTaskItem();
      _getCountTaskItem();
    }
  }
}
