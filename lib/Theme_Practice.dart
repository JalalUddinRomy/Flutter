import 'package:flutter/material.dart';
import 'package:flutter_one/button_alartdialog.dart';
//Text field,Theme data, Text Button
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.black87,
              width: 2
            )
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.deepOrangeAccent,
                  width: 3
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.green,
              width: 2
            )
          ),
          hintStyle:TextStyle(
            fontSize: 12
          ),
          labelStyle: TextStyle(
            color: Colors.deepOrangeAccent
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.deepOrangeAccent,
            textStyle: TextStyle(
              fontSize: 8,
              color: Colors.greenAccent,
            )
          )
        )
      ),
      darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black87,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 1.5,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Colors.greenAccent,
                      width: 2
                  )
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Colors.deepOrangeAccent,
                      width: 3
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2
                  )
              ),
              hintStyle:TextStyle(
                  fontSize: 12
              ),
              labelStyle: TextStyle(
                  color: Colors.deepOrangeAccent
              )
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.deepOrangeAccent,
                  textStyle: TextStyle(
                    fontSize: 8,
                    color: Colors.greenAccent,
                  )
              )
          )
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Theme Practice")),
      body: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "User Name",
                  hintText: 'Name',
                  suffixIcon : TextButton(onPressed: (){}, child:Text('Search'))
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: 'Password'
                ),
              ),
            ],
          ),)),
    );
  }
}
