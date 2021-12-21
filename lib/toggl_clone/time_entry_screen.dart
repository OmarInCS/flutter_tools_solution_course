
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
    DateTime? date;
    if (getDate) {
      date = await showDatePicker(
          context: context,
          firstDate: DateTime.now().subtract(Duration(days: 7)),
          lastDate: DateTime.now(),
          initialDate: DateTime.now(),
          helpText: dateLabel
      ) ?? DateTime.now();
    }
    else {
      date = timeEntry.startTime;
    }
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
              child: TextField(
                controller: tfController,
                decoration: InputDecoration(
                  labelText: "Description"
                ),
                onSubmitted: (value) {
                  timeEntry.description = value;
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DropdownButtonFormField(
                onChanged: (value) {
                  timeEntry.project = Project.dummyProjects.firstWhere((project) => project.projectName == value);
                },
                items: [
                  for (var project in Project.dummyProjects)
                    DropdownMenuItem(
                      child: Text(
                        project.projectName
                      ),
                      value: project.projectName,
                    )
                ],
              )
            ),
          ],
        ),
      ),
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: null,
          child: Icon(Icons.add),
          onPressed: () async {
            timeEntry.endTime = await getDateTime(getDate: false, timeLabel: "End Time");
            TimeEntry.dummyEntries.add(timeEntry);
            Navigator.pushNamed(context, TogglHomeScreen.routeName);
          },
        ),
        SizedBox(height: 8,),
        FloatingActionButton(
          heroTag: null,
          child: Icon(Icons.play_arrow),
          onPressed: null,
        ),

      ],
    ),
    );
  }
}
