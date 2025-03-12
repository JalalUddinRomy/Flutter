import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_one/fragments/commentFragment.dart';
import 'package:flutter_one/fragments/homeFragment.dart';
import 'package:flutter_one/fragments/mailFragment.dart';
import 'package:flutter_one/fragments/searchFragment.dart';
import 'package:flutter_one/fragments/settingFragment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeActivity());
  }
}

class HomeActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(appBar: AppBar(title: Text("Fragment Practice"),
        backgroundColor: Colors.greenAccent,
        bottom: TabBar(
          isScrollable: true
          , tabs: [
          Tab(icon: Icon(Icons.home), text: "Home",),
          Tab(icon: Icon(Icons.search), text: "Search",),
          Tab(icon: Icon(Icons.mail), text: "Mail",),
          Tab(icon: Icon(Icons.comment), text: "Comment",),
          Tab(icon: Icon(Icons.settings), text: "Settings",)
        ],),),
        body: TabBarView(
            children:[
              HomefragmentActivity(),
              SearchActivity(),
              MailActivity(),
              CommentActivity(),
              SettingActivity()
            ]),),
    );
  }
}
