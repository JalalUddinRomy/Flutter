import 'package:get/get.dart';
import 'package:task_manager_getx/Controller/cancelled_task_controller.dart';
import 'package:task_manager_getx/Controller/complete_task_controller.dart';
import 'package:task_manager_getx/Controller/count_task_controller.dart';
import 'package:task_manager_getx/Controller/email_verfication_controller.dart';
import 'package:task_manager_getx/Controller/newTask_controller.dart';
import 'package:task_manager_getx/Controller/pin_verification_controller.dart';
import 'package:task_manager_getx/Controller/progress_task_controller.dart';
import 'package:task_manager_getx/Controller/sign_in_controller.dart';
import 'package:task_manager_getx/Controller/reset_password_controller.dart';
import 'package:task_manager_getx/Controller/sign_up_controller.dart';
import 'package:task_manager_getx/Controller/update_profile_controller.dart';

class ControllerBinders extends Bindings{
  @override
  void dependencies() {
  Get.put(SignInController());
  Get.put(NewTaskController());
  Get.put(CountTaskController());
  Get.put(CompleteTaskController());
  Get.put(CancelledTaskController());
  Get.put(ProgressTaskController());
  Get.put(ResetPasswordController());
  Get.put(PinVerificationController());
  Get.put(EmailVerificationController());
  Get.put(SignUpController());
  Get.put(UpdateProfileController());
  }

}