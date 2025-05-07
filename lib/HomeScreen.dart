import 'package:flutter/material.dart';
import 'package:water_tracker_app/waterTracker.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _addAmountOfGlassTEController = TextEditingController(
      text: "1");
  List<WaterTracker> waterTrackerList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Tracker", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWatertrackerHeading(),
          SizedBox(height: 24,),
          Expanded(
            child: _buildListviewSeperated(),
          ),
        ],
      ),
    );
  }

  Widget _buildListviewSeperated() {
    return ListView.separated(
            itemCount: waterTrackerList.length,
            itemBuilder: (context, index) {
              return listTileofListview(index);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },

          );
  }

  ListTile listTileofListview( int index) {
    WaterTracker waterData=waterTrackerList[index];
    return ListTile(
              title: Text("${waterData.dateTime.hour} :${waterData.dateTime
                  .minute}"),
              subtitle: Text(
                  "${waterData.dateTime.day} / ${waterData.dateTime
                      .month} / ${waterData.dateTime.year}"),
              leading: CircleAvatar(
                  child: Text("${waterData.amountOfGlass}")),
              trailing: IconButton(onPressed: () {
                _onTapDeleteTrack(index);
              }, icon: Icon(Icons.delete)),
            );
  }

  Widget _buildWatertrackerHeading() {
    return Column(
          children: [
            Text(getTotalGlassCount().toString(),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            Text(
              "Glass's",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _addAmountOfGlassTEController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: _ontapAddWaterTrack, child: Text("Add")),
              ],
            ),
          ],
        );
  }

  void _ontapAddWaterTrack() {
    if (_addAmountOfGlassTEController.text.isEmpty) {
      _addAmountOfGlassTEController.text = '1';
    }
    final int _noOfglass = int.tryParse(_addAmountOfGlassTEController.text) ?? 1;
    WaterTracker waterTracker = WaterTracker(
        amountOfGlass: _noOfglass, dateTime: DateTime.now());
   // waterTrackerList.add(waterTracker);
    waterTrackerList.insert(0,waterTracker);
    setState(() {});
    _addAmountOfGlassTEController.clear();
  }

  int getTotalGlassCount() {
    int count = 0;
    for (WaterTracker t in waterTrackerList) {
      count += t.amountOfGlass;
      //print("Botton pressed");
    }
    return count;
  }

  void _onTapDeleteTrack(int index) {
    waterTrackerList.removeAt(index);
    setState(() {});
  }

  @override
  void dispose() {
    _addAmountOfGlassTEController.dispose();
    super.dispose();
  }

}

