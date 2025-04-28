import 'package:flutter/material.dart';

void main(){
  runApp(Myapp());
}
class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FractionActivity(),
    );
  }

}
class FractionActivity extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fractionally Sized box"),
        backgroundColor: Colors.deepOrangeAccent      ),
      body: Container(
        height: MediaQuery.of(context).size.width,
        width:MediaQuery.of(context).size.width,
        color: Colors.lightGreen,
        child: FractionallySizedBox(
          heightFactor: 0.5,
          widthFactor: 0.5,
          child: Container(

            decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.circular(100)
            ),
          ),

      ),
    ));
  }

}