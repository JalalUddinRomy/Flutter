import 'package:flutter/material.dart';

void main(){
  runApp(Myapp());
}
class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(home: FormActivity(),);
  }

}
class FormActivity extends StatelessWidget{
  @override
  ButtonStyle buttonStyle=ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 60),backgroundColor: Colors.lightGreen);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Field"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(10),child: TextField(decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Name"),),),
          Padding(padding: EdgeInsets.all(10),child: TextField(decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Email"),),),
          Padding(padding: EdgeInsets.all(5),child: ElevatedButton(onPressed: (){},style: buttonStyle, child:Text("Submit")),),
        ],
      ),
    );
  }

}