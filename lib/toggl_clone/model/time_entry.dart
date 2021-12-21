


import 'project.dart';

class TimeEntry {
  DateTime startTime;
  String description;
  DateTime? endTime;
  Project? project;

  static final dummyEntries = [
    new TimeEntry(
      DateTime.now().subtract(Duration(days: 1, hours: 1)),
      "Do Some Thing",
      endTime: DateTime.now().subtract(Duration(hours: 22, minutes: 30)),
      project: Project.dummyProjects[0]
    ),
    new TimeEntry(
      DateTime.now().subtract(Duration(days: 2, hours: 1)),
      "Do Some Thing",
      endTime: DateTime.now().subtract(Duration(hours: 22 * 2)),
      project: Project.dummyProjects[1]
    ),
    new TimeEntry(
      DateTime.now().subtract(Duration(days: 1, hours: 12)),
      "Do Some Thing",
      endTime: DateTime.now().subtract(Duration(days: 1, hours: 10, minutes: 30)),
      project: Project.dummyProjects[0]
    ),
    new TimeEntry(
      DateTime.now().subtract(Duration(days: 1, hours: 4)),
      "Do Some Thing",
      endTime: DateTime.now().subtract(Duration(hours: 24, minutes: 30)),
      project: Project.dummyProjects[1]
    ),
  ];

  TimeEntry(this.startTime, this.description, {this.endTime, this.project});
}