


import 'package:intl/intl.dart';

import 'project.dart';

class TimeEntry{
  int? entryId;
  DateTime startTime;
  String description;
  DateTime? endTime;
  Project? project;

  TimeEntry({this.entryId, required this.startTime, required this.description, this.endTime, this.project});

  TimeEntry.fromMap(Map<String, dynamic> res)
      : this(
    startTime: DateFormat("yyyy-MM-dd hh:mm").parse(res["startTime"]),
    entryId: res["entryId"],
    description: res["description"],
    endTime: DateFormat("yyyy-MM-dd hh:mm").parse(res["endTime"]),
    project: res["project"],
  );

  Map<String, dynamic> toMap() {
    return {
      "projectId": project?.projectId,
      "entryId": entryId,
      "startTime": DateFormat("yyyy-MM-dd HH:mm").format(startTime),
      "description": description,
      "endTime": endTime != null? DateFormat("yyyy-MM-dd HH:mm").format(endTime!) : null,
    };
  }
}