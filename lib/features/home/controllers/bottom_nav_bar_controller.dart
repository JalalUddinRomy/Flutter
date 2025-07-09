import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    if (index == _selectedIndex) {
      return;
    } else {
      _selectedIndex = index;
      update();
    }
  }

  void backToHome() {
    changeIndex(0);
  }

  void moveToCategory() {
    changeIndex(1);
  }
}
