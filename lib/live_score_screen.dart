import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_app_using_getx/add_new_match.dart';
import 'package:counter_app_using_getx/cricket_Model.dart';
import 'package:flutter/material.dart';

class LiveScoreScreen extends StatefulWidget {
  @override
  State<LiveScoreScreen> createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  List<CricketScore> _cricketscoreList = [];

  void _extractData(QuerySnapshot<Map<String, dynamic>>? snapshot) {
    _cricketscoreList.clear();
    for (DocumentSnapshot doc in snapshot?.docs ?? []) {
      _cricketscoreList.add(
        CricketScore.fromJson(doc.id, doc.data() as Map<String, dynamic>),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cricket Live Score")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Cricket').snapshots(),
        builder: (
          context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            _extractData(snapshot.data);
            return ListView.builder(
              itemCount: _cricketscoreList.length,
              itemBuilder: (context, index) {
                CricketScore cricketScore = _cricketscoreList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _statusIndicator(
                      cricketScore.isMatchRunning,
                    ),
                  ),
                  title: Text(cricketScore.ModelId),
                  subtitle: Text(
                    "Team One : ${cricketScore.TeamOneName}\n"
                    "Team Two: ${cricketScore.TeamTwoName}\n"
                    "Winner Team:${cricketScore.winningTeam == '' ? 'Pending' : cricketScore.winningTeam}",
                  ),
                  trailing: Text(
                    '${cricketScore.TeamOneScore}/${cricketScore.TeamTwoScore}',
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewMatchScreen()));
        },
        child: Icon(Icons.add ),
      ),
    );
  }

  Color _statusIndicator(bool isMatchRunning) {
    return isMatchRunning ? Colors.green : Colors.grey;
  }
}
