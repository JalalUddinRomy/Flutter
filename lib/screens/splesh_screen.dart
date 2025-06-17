import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/Controller/auth_controller.dart';
import 'package:todo_app/screens/main_bottom_nav_bar.dart';
import 'package:todo_app/screens/sign_in_screen.dart';
import 'package:todo_app/utils/imagepath.dart';

import '../widgets/screen_background.dart' show screenBackground;

class spleshScreen extends StatefulWidget {
  const spleshScreen({super.key});

  @override
  State<spleshScreen> createState() => _spleshScreenState();
}

class _spleshScreenState extends State<spleshScreen> {
  @override
  void initState() {
    super.initState();
    _movetonextscreen();
  }

  Future<void> _movetonextscreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await AuthController.getAccessToken();
    await AuthController.getUserData();
    if(AuthController.isLoggedIn()){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainBottomNavBar()),
      );
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const signInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset(Imagepath.logo_image, width: 160)],
          ),
        ),
      ),
    );
  }
}
