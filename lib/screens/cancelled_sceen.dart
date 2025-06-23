import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/Controller/cancelled_task_controller.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/snackbar_message.dart' show showSnackbarMessage;
import '../widgets/task_card.dart' show TaskCard;

class CancelledScreen extends StatefulWidget {
  const CancelledScreen({super.key});

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {

  @override
  void initState() {
    super.initState();
    _getCancelledTaskItem();
  }

  CancelledTaskController cancelledTaskController = Get.find<
      CancelledTaskController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getCancelledTaskItem();
      },
      child: GetBuilder<CancelledTaskController>(
          builder: (controller) {
            return Visibility(
              visible: !controller.inprogress,
              replacement: CenterCircularProgressIndicator(),
              child: ListView.separated(
                itemCount: controller.CancelledTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskModel: controller.CancelledTaskList[index],
                    onRefreshLIst: _getCancelledTaskItem,
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

  Future<void> _getCancelledTaskItem() async {
    bool result = await cancelledTaskController.getCancelledTaskItem();
    if (!result) {
      showSnackbarMessage(context, cancelledTaskController.errorMessage!, true);
    }
  }
}
