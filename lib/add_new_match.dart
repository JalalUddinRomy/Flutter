import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_app_using_getx/cricket_Model.dart';
import 'package:flutter/material.dart';

class AddNewMatchScreen extends StatefulWidget {
  @override
  State<AddNewMatchScreen> createState() => _AddNewMatchScreenState();
}

class _AddNewMatchScreenState extends State<AddNewMatchScreen> {
  final TextEditingController OneNameTEcontroller = TextEditingController();
  final TextEditingController TwoNameTEcontroller = TextEditingController();
  final TextEditingController OneScoreTEcontroller = TextEditingController();
  final TextEditingController TwoScoreTEcontroller = TextEditingController();
  final TextEditingController winnerTEcontroller = TextEditingController();
  final TextEditingController MatchIdTEcontroller = TextEditingController();
  bool _ismatchRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Match")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: MatchIdTEcontroller,
              decoration: InputDecoration(hintText: 'Match Id'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: OneNameTEcontroller,
              decoration: InputDecoration(hintText: 'Team One Name'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: TwoNameTEcontroller,
              decoration: InputDecoration(hintText: 'Team Two Name'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: OneScoreTEcontroller,
              decoration: InputDecoration(hintText: 'Team One Score'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: TwoScoreTEcontroller,
              decoration: InputDecoration(hintText: 'Team Two Score'),
            ),
            SizedBox(height: 5),
            SwitchListTile(
              title: Text('Is Match runnning?'),
              value: _ismatchRunning,
              onChanged: (bool value) {
                _ismatchRunning = value;
                setState(() {});
              },
            ),
            SizedBox(height: 5),
            TextField(
              controller: winnerTEcontroller,
              decoration: InputDecoration(hintText: 'Winner Team'),
            ),
            SizedBox(height: 5),
            ElevatedButton(onPressed: () {
              _addNewMatch();
            }, child: Text('Add')),
          ],
        ),
      ),
    );
  }

  void _addNewMatch() async {
    CricketScore newMatch = CricketScore(
      ModelId: MatchIdTEcontroller.text,
      TeamOneName: OneNameTEcontroller.text,
      TeamTwoName: TwoNameTEcontroller.text,
      TeamOneScore: int.parse(OneScoreTEcontroller.text),
      TeamTwoScore: int.parse(TwoScoreTEcontroller.text),
      isMatchRunning: _ismatchRunning,
      winningTeam: winnerTEcontroller.text,
    );
    FirebaseFirestore.instance.collection('Cricket').doc(newMatch.ModelId).set(newMatch.toJson());
  }
}
