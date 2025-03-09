import 'package:flutter/material.dart';

void main(){
  runApp(NewApp());
}
class NewApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: RowActivity()
   );
  }
  
}
class RowActivity extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title:  Text("Container Practice"),backgroundColor: Colors.blueAccent,),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 250,
            child: Text("My container"),
            alignment:Alignment.center,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.fromLTRB(12,13,14,15),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              border: Border.all(width: 2,color: Colors.black),
              borderRadius: BorderRadius.circular(10)
            ),
          )
        ],
      ),
    );
  }
  
}