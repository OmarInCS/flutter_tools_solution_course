

import 'dart:async';

import 'package:aladl_project/toggl_clone_api/service/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'model/time_entry.dart';
import 'time_entry_screen.dart';

class TogglHomeScreen extends StatefulWidget {
  TogglHomeScreen({Key? key, this.runningEntry}) : super(key: key);

  TimeEntry? runningEntry;
  static const routeName = "/home";

  @override
  _TogglHomeScreenState createState() => _TogglHomeScreenState();
}

class _TogglHomeScreenState extends State<TogglHomeScreen> {

  Timer? timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  Icon actionIcon = Icon(Icons.add);
  TimeEntry? runningEntry;
  late DioClient _dio;

  BottomSheet getBottomSheet() {

    actionIcon = Icon(Icons.stop);

      return BottomSheet(
        builder: (context) => ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${NumberFormat("00").format(hours)}:${NumberFormat("00").format(minutes)}:${NumberFormat("00").format(seconds)}",
                  style: TextStyle(
                fontSize: 20
            ),
            ),
          ),
          title: Text(
              runningEntry!.project?.projectName ?? "No Project"
          ),
          subtitle: Text(
              runningEntry!.description
          ),
        ),
        onClosing: () {},
      );
  }

  Future<void> handleFloatButtonAction() async {

    if (actionIcon.icon == Icons.add) {
      Navigator.pushNamed(context, TimeEntryScreen.addEntry);
    }
    else {
      runningEntry!.endTime = DateTime.now();
      // TimeEntry.dummyEntries.add(runningEntry!);
      // await _db.insertTimeEntry(runningEntry!);
      timer!.cancel();
      runningEntry = null;
      actionIcon = Icon(Icons.add);
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dio = DioClient();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    runningEntry = ModalRoute.of(context)!.settings.arguments as TimeEntry?;

    if (runningEntry != null) {
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
      body: FutureBuilder(
        future: _dio.getTimeEntries(),
        builder: (context, AsyncSnapshot<List<TimeEntry>?> snapshot) {
          if (snapshot.hasData) {
            return GroupedListView(
              elements: snapshot.data!..sort((te1, te2) => te1.startTime.difference(te2.startTime).inSeconds),
              groupBy: (TimeEntry element) => DateFormat.yMMMd().format(element.startTime),
              groupSeparatorBuilder: (String dayDate) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    dayDate
                ),
              ),
              order: GroupedListOrder.DESC,
              itemBuilder: (context, TimeEntry element) => Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 2
                    )
                ),
                child: ListTile(
                  title: Text(
                      element.project?.projectName ?? "No Project"
                  ),
                  subtitle: Text(
                      element.description
                  ),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(DateFormat.Hm().format(element.startTime)),
                      SizedBox(height: 8,),
                      Text(DateFormat.Hm().format(element.endTime!)),
                    ],
                  ),
                  trailing: Text(
                      NumberFormat.currency(symbol: "SAR ").format(
                          element.endTime!.difference(element.startTime).inMinutes / 60 * element.project!.hourRate
                      )
                  ),
                ),
              ),
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: actionIcon,
        onPressed: handleFloatButtonAction,
      ),
      bottomSheet: runningEntry != null ? getBottomSheet() : null,
    );
  }
}
