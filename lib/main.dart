import 'package:counter_app_using_getx/home_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(CounterApp());
}
class CounterApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }

}