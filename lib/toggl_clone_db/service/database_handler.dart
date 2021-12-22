

import 'package:aladl_project/toggl_clone_db/model/project.dart';
import 'package:aladl_project/toggl_clone_db/model/time_entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHandler {

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "toggl5.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            """
            Create TABLE projects 
            (
              projectId integer PRIMARY KEY AUTOINCREMENT,
              projectName varchar(30) NOT NULL,
              clientName varchar(30),
              hourRate integer DEFAULT 0
            );
            """);

        await db.execute("""
            CREATE TABLE time_entries
            (
              entryId integer PRIMARY KEY AUTOINCREMENT,
              startTime text NOT NULL,
              description text NOT NULL,
              endTime text,
              projectId integer REFERENCES projects(projectId)
            );
            
          """,
        );

        await db.rawInsert("""
          INSERT INTO projects (projectname, clientname, hourrate)
            VALUES ('Toggl Clone', 'Omar Karem', 100);
            
        """);
        await db.rawInsert("""
          INSERT INTO projects (projectname, clientname, hourrate)
            VALUES ('Stock Market Analyzer', 'Majid Alhamzah', 150);
              
        """);
        await db.rawInsert("""
          INSERT INTO projects (projectname, clientname, hourrate)
            VALUES ('Scratch Clone', 'Fay', 150);
            
        """);
        await db.rawInsert("""
          INSERT INTO time_entries (starttime, description, endtime, projectid)
            values ('2021-08-16 01:00', 'Do First Task', '2021-08-16 02:30', 1);
            
        """);
        await db.rawInsert("""
          INSERT INTO time_entries (starttime, description, endtime, projectid)
            values ('2021-08-16 07:00', 'Do First Task', '2021-08-16 09:30', 2);
             
        """);
        await db.rawInsert("""
          INSERT INTO time_entries (starttime, description, endtime, projectid)
            values ('2021-08-17 01:00', 'Do Second Task', '2021-08-17 03:30', 1);
           
        """);
        await db.rawInsert("""
          INSERT INTO time_entries (starttime, description, endtime, projectid)
            values ('2021-08-15 14:00', 'Do First Task', '2021-08-15 18:30', 3);
            
        """);

      },
    );
  }

  Future<List<Project>> getProjects() async {
    final db = await initDatabase();
    List<Map<String, dynamic>> result = await db.query("projects");
    return result.map((e) => Project.fromMap(e)).toList();
  }

  Future<List<TimeEntry>> getTimeEntries() async {
    final db = await initDatabase();
    List<Map<String, dynamic>> result = await db.query("time_entries");
    List<Map<String, dynamic>> newResult = [];
    for (var entryMap in result) {
      Map<String, dynamic> newEntryMap = Map.from(entryMap);
      List<Map<String, dynamic>> projectMap = await db.query("projects", where: "projectId = ?", whereArgs: [newEntryMap["projectId"]]);
      newEntryMap["project"] = Project.fromMap(projectMap[0]);
      newResult.add(newEntryMap);
    }
    return newResult.map((e) => TimeEntry.fromMap(e)).toList();
  }

  Future<void> insertTimeEntry(TimeEntry entry) async {
    final db = await initDatabase();
    await db.insert("time_entries", entry.toMap());
  }

}