//Card
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(CardApp());
}
class CardApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Card Practice"),),
        body: Center(
          child: Card(
            color: Colors.amberAccent,
            shadowColor: Colors.amberAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.elliptical(80,12))),
            elevation: 70,
            child: SizedBox(
              height: 220,
              width: 220,
              child: Center(
                child: Text("This is a Card"),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
}