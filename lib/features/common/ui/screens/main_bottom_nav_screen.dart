import 'package:ecommerceapp/features/home/controllers/bottom_nav_bar_controller.dart';
import 'package:ecommerceapp/features/home/ui/screens/categories_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/ui/screens/home_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});
  static const String name='/main_bottomNavScreen';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens=[
    HomeScreen(),
   CategoriesListScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(
      builder: (bottomNavController) {
        return Scaffold(
          body: _screens[bottomNavController.selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: bottomNavController.selectedIndex,
          onDestinationSelected: bottomNavController.changeIndex,
          destinations: [
           NavigationDestination(icon:Icon(Icons.home), label: 'Home'),
           NavigationDestination(icon:Icon(Icons.category_outlined), label: 'Categories'),
           NavigationDestination(icon:Icon(Icons.shopping_cart), label: 'Cart'),
           NavigationDestination(icon:Icon(Icons.favorite), label: 'Wish'),
          ],
        ),
        );
      }
    );
  }
}
