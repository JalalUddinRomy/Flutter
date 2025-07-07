import 'package:ecommerceapp/features/home/controllers/bottom_nav_bar_controller.dart';
import 'package:get/get.dart';

class ControllerBinders extends Bindings{
  @override
  void dependencies() {
    Get.put(BottomNavBarController());
  }

}