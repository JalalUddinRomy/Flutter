import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_getx/screens/sign_in_screen.dart';
import '../Controller/auth_controller.dart';
import '../utils/imagepath.dart';
import '../widgets/screen_background.dart' show screenBackground;
import 'main_bottom_nav_bar.dart';

class spleshScreen extends StatefulWidget {
  static const String name='/';
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
