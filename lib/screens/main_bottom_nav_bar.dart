import 'package:flutter/material.dart';
import 'package:task_manager_getx/screens/progress_screen.dart';
import '../widgets/tm_app_bar.dart';
import 'cancelled_sceen.dart';
import 'completed_screen.dart';
import 'new_task_screen.dart';

class MainBottomNavBar extends StatefulWidget {
  static const String name = '/home';
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

int _selectedIndex = 0;
List<Widget> _screenList = [
  NewTaskScreen(),
  CompletedScreen(),
  CancelledScreen(),
  ProgressScreen(),
];

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        onProfileUpdated:_refreshUserData,
      ),
      body: _screenList[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(
            icon: Icon(Icons.check_box),
            label: 'Completed',
          ),
          NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
          NavigationDestination(
            icon: Icon(Icons.incomplete_circle_outlined),
            label: 'Progress',
          ),
        ],
      ),
    );
  }

  void _refreshUserData() {
    setState(() {

    });
  }
}


