
import 'package:flutter/material.dart';

import 'model/project.dart';
import 'model/time_entry.dart';
import 'toggl_home_screen.dart';


class TimeEntryScreen extends StatefulWidget {
  const TimeEntryScreen({Key? key}) : super(key: key);

  @override
  _TimeEntryScreenState createState() => _TimeEntryScreenState();
}

class _TimeEntryScreenState extends State<TimeEntryScreen> {

  TimeEntry timeEntry = new TimeEntry(DateTime.now(), "...");
  var tfController = TextEditingController();

  DateTime? getDateTime({getDate = true, String? dateLabel, String? timeLabel}) {


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Entry"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(
                      "",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: null
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: null
            ),
          ],
        ),
      ),

    );
  }
}
