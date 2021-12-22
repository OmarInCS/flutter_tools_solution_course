// To parse this JSON data, do
//
//     final timeEntry = timeEntryFromJson(jsonString);

import 'dart:convert';

import 'package:aladl_project/toggl_clone_api/model/project.dart';
import 'package:intl/intl.dart';



class TimeEntry {
  TimeEntry({
    required this.description,
    this.endTime,
    this.entryId,
    this.project,
    required this.startTime,
  });

  String description;
  DateTime? endTime;
  int? entryId;
  Project? project;
  DateTime startTime;

  TimeEntry.fromJson(Map<String, dynamic> json) : this(
        description: json["description"],
        endTime: DateFormat("yyyy-MM-dd HH:mm").parse(json["endTime"]),
        entryId: json.containsKey("entryId") ? json["entryId"] : null,
        project: Project.fromJson(json["project"]),
        startTime: DateFormat("yyyy-MM-dd HH:mm").parse(json["startTime"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "endTime": endTime != null ? DateFormat("yyyy-MM-dd HH:mm").format(endTime!) : null,
        "entryId": entryId,
        "projectId": project?.projectId,
        "startTime": DateFormat("yyyy-MM-dd HH:mm").format(startTime),
      };
}
