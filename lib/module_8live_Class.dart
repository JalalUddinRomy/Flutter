import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeActivity(),
    );
  }

}
class HomeActivity extends StatelessWidget{
  List<String> FriendList=["Farhan","Jisan","Mizbah","Sipon"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Separator Builder Practice"),
        backgroundColor: Colors.red,
      ),
      body: ListView.separated(
          itemCount: FriendList.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(index.toString()),
              subtitle: Text(FriendList[index]),
            );
          }, separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 24,
              color: Colors.greenAccent,
              thickness: 4,
              endIndent: 30,
              indent: 5,
            );
      }, ),
    );
  }

}