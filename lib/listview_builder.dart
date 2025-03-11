import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//listview,container,gesture detector,image radius
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BuilderActivity());
  }
}

class BuilderActivity extends StatelessWidget {
  var ListItems = [
    {"img": "assets/images/ajrin.jpeg", "Name": "Jalal"},
    {"img": "assets/images/ajrin.jpeg", "Name": "Ajrin"},
    {"img": "assets/images/ajrin.jpeg", "Name": "Romy"},
    {"img": "assets/images/ajrin.jpeg", "Name": "Belal"},
    {"img": "assets/images/ajrin.jpeg", "Name": "Jalal"},
  ];
  Mysnackbar(message,context){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listview Practice'),
        backgroundColor: Colors.blue,
        leading: Icon(Icons.heart_broken_rounded,color: Colors.red),
      ),
      body: ListView.builder(
        itemCount: ListItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onDoubleTap: () {
              Mysnackbar(ListItems[index]["Name"], context);
            },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 500,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    ListItems[index]["img"]!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
