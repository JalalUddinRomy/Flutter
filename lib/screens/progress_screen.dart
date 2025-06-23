import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/Controller/progress_task_controller.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/snackbar_message.dart';
import '../widgets/task_card.dart' show TaskCard;

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {

  @override
  void initState() {
    super.initState();
    _getProgressTaskItem();
  }
  ProgressTaskController progressTaskController=Get.find<ProgressTaskController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getProgressTaskItem();
      },
      child: GetBuilder<ProgressTaskController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.inprogress,
            replacement: CenterCircularProgressIndicator(),
            child: ListView.separated(
              itemCount:controller.ProgressTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: controller.ProgressTaskList[index],
                  onRefreshLIst: _getProgressTaskItem,
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

  Future<void> _getProgressTaskItem() async {
    bool result=await progressTaskController.getProgressTaskItem();
    if (!result) {
      showSnackbarMessage(context,progressTaskController.errorMessage!, true);
    } else {

    }
  }
}
