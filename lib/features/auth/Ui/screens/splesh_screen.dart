import 'package:ecommerceapp/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/app_icon_widget.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});
  static String name='/';

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  void initState() {
    super.initState();
    _gotoNextScreen();
  }
  Future<void> _gotoNextScreen() async{
   await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context,MainBottomNavScreen.name);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: AppIconWidget(),
            ),
            Spacer(),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}


