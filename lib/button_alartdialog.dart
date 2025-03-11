import 'package:flutter/material.dart';
//Button AlartDialog

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AlartActivity(),
    );
  }

}

class AlartActivity extends StatelessWidget {
  MyAlartDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Expanded(child: AlertDialog(
            title: Text("Alart"),
            content: Text("Do you want to leave"),
            actions: [
              TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Yes")),
              TextButton(onPressed: (){}, child: Text("NO"))
            ],
          ));

        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Practicing Button and Alart Dialog"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {
          MyAlartDialog(context);
        }, child: Text("Click")),
      ),
    );
  }

}