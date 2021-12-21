

import 'dart:async';

import 'package:flutter/material.dart';
import 'model/time_entry.dart';
import 'time_entry_screen.dart';

class TogglHomeScreen extends StatefulWidget {
  TogglHomeScreen({Key? key, this.runningEntry}) : super(key: key);

  TimeEntry? runningEntry;

  @override
  _TogglHomeScreenState createState() => _TogglHomeScreenState();
}

class _TogglHomeScreenState extends State<TogglHomeScreen> {

  Timer? timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  Icon actionIcon = Icon(Icons.add);

  BottomSheet? getBottomSheet() {

  }

  void handleFloatButtonAction() {


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds += 1;
        if (seconds == 60) {
          minutes += 1;
          seconds = 0;
        }

        if (minutes == 60) {
          hours += 1;
          minutes = 0;
          seconds = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Entries"),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              child: Text(
                "Toggl Clone",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor
              ),
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text("Time Entries"),
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: Text("Projects"),
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text("Reports"),
            ),

          ],
        ),
      ),
      body: ,
    );
  }
}
