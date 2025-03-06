import 'package:flutter/material.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Homeactivity());
  }
}

class Homeactivity extends StatelessWidget {
  const Homeactivity({super.key});

  appBarSnackBar(Message, context) {
    return ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(Message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First app"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              appBarSnackBar("Comment Here", context);
            },
            icon: Icon(Icons.comment),
          ),
          IconButton(
            onPressed: () {
              appBarSnackBar("Search Here", context);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appBarSnackBar('go right', context);
        },
        elevation: 13,
        child: Icon(Icons.arrow_circle_right_outlined),
        backgroundColor: Colors.amber,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Colors.amber,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Contact"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        ],
        onTap: (int index) {
          if (index == 0) {
            appBarSnackBar('Hi i am Home', context);
          }
          if (index == 1) {
            appBarSnackBar('Hi I am Contact', context);
          }
          if (index == 2) {
            appBarSnackBar('Hi I am People', context);
          }
          ;
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(0),

              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.amber),
                accountName: Text("Md Jalal Uddin",style: TextStyle(color: Colors.black),),
                accountEmail: Text('Jalal@gmail.com',style: TextStyle(color: Colors.black)),
                currentAccountPicture: Image.network(""),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                appBarSnackBar('Go to Home', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text("Link"),
              onTap: () {
                appBarSnackBar('Go to Link', context);
              },
            ),
            ListTile(
              leading: Icon(Icons.more),
              title: Text("More"),
              onTap: () {
                appBarSnackBar('Go to More', context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
