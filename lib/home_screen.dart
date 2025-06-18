import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RxInt count = 0.obs;
  //eikane getX state management tool dia state manage kora hoice jeno jei function gula re build howa dorkar kali shei function gulai rebuild hoy ete kore phone er better power consume hoy

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home"))
    ,
    floatingActionButton: FloatingActionButton(
    onPressed: () {countValue();},
    child: Icon(Icons.add),),
    body: Center(
    child: Obx((){
    return Text(
    '${count}',
    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),);}),),);}

  void countValue() {
    count++;
  }
}
