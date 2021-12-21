
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/project.dart';
import 'model/time_entry.dart';
import 'toggl_home_screen.dart';


class TimeEntryScreen extends StatefulWidget {
  const TimeEntryScreen({Key? key}) : super(key: key);
  static const addEntry = "/addEntry";
  @override
  _TimeEntryScreenState createState() => _TimeEntryScreenState();
}

class _TimeEntryScreenState extends State<TimeEntryScreen> {

  TimeEntry timeEntry = new TimeEntry(DateTime.now(), "...");
  var tfController = TextEditingController();

  Future<DateTime> getDateTime({getDate = true, String? dateLabel, String? timeLabel}) async {

    var date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 7)),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      helpText: dateLabel
    ) ?? DateTime.now();

    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: timeLabel,
    ) ?? TimeOfDay.now();

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);

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
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        DateFormat.yMMMd().format(timeEntry.startTime),
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    Text(
                        DateFormat.Hm().format(timeEntry.startTime),
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                timeEntry.startTime = await getDateTime(dateLabel: "Start Date", timeLabel: "Start Time");
                setState(() {

                });
              },
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
