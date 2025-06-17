import 'package:flutter/material.dart';
import 'package:todo_app/screens/cancelled_sceen.dart';
import 'package:todo_app/screens/completed_screen.dart';
import 'package:todo_app/screens/new_task_screen.dart';
import 'package:todo_app/screens/progress_screen.dart';
import '../widgets/tm_app_bar.dart';

class MainBottomNavBar extends StatefulWidget {
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


