import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/Controller/complete_task_controller.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/snackbar_message.dart' show showSnackbarMessage;
import '../widgets/task_card.dart' show TaskCard;

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {

  @override
  void initState() {
    super.initState();
    _getCompletedTaskItem();
  }

  CompleteTaskController completeTaskController = Get.find<
      CompleteTaskController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getCompletedTaskItem();
      },
      child: GetBuilder<CompleteTaskController>(
          builder: (controller) {
            return Visibility(
              visible: !controller.inprogress,
              replacement: CenterCircularProgressIndicator(),
              child: ListView.separated(
                itemCount: controller.CompletedTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskModel: controller.CompletedTaskList[index],
                    onRefreshLIst: _getCompletedTaskItem,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
              ),
            );
          }
      ),
    );
  }

  Future<void> _getCompletedTaskItem() async {
    final bool result = await completeTaskController.getCompletedTaskItem();
    if (!result) {
      showSnackbarMessage(context, completeTaskController.errorMessage!, true);
    }
  }
}
