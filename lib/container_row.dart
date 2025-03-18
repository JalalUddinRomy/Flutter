import 'package:flutter/material.dart';
//container,row
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              child: Text("My container"),
              alignment:Alignment.bottomRight,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.fromLTRB(12,13,14,15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2,color: Colors.black),
                borderRadius: BorderRadius.only(
                  bottomLeft:Radius.circular(16),
                  topRight: Radius.circular(16)
                ),
                image: DecorationImage(
                    image: AssetImage("assets/images/ajrin.jpeg"),fit: BoxFit.fill,opacity: 0.7),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3)
                  )
                ]
              ),

            )
          ],
        ),
      ),
    );
  }
  
}