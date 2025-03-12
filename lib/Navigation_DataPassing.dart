import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen(),);
  }
}
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),backgroundColor: Colors.greenAccent,),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>ActivityONe("I am from Home")));
            }, child: Text("Activity One")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>ActivityTwo("I am from Home")));
            }, child: Text("Activity Two")),
          ],
        ),
      ),
    );
  }

}
class ActivityONe extends StatelessWidget{
  String message;
     ActivityONe(
      this.message,
      {super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('Activity One'),backgroundColor: Colors.red,),
     body: Column(children: [
       Text(message),
       ElevatedButton(onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder:(context)=>ActivityTwo("I am from Activity One Hi!")));
       }, child: Text("Activity Two"))

     ],)
   );
  }

}
class ActivityTwo extends StatelessWidget{
  String Txt;
   ActivityTwo(
      this.Txt,{super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('Activity Two'),backgroundColor: Colors.amberAccent,),
     body: Column(children: [
       Text(Txt),
       ElevatedButton(onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder:(context)=>ActivityONe("I am from Activity Two Hello!")));
       }, child: Text("Activity One"))

     ],)
   );
  }

}
