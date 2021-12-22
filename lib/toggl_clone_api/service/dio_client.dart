
import 'package:aladl_project/toggl_clone_api/model/project.dart';
import 'package:aladl_project/toggl_clone_api/model/time_entry.dart';
import 'package:dio/dio.dart';

class DioClient {

  final _baseUrl = 'https://toggl-clone-api.herokuapp.com';
  final Dio _dio = Dio();

  Future<List<TimeEntry>?> getTimeEntries() async {
    var response = await _dio.get(_baseUrl + "/entries");

    if (response.statusCode == 200) {
      return [for (var item in response.data) TimeEntry.fromJson(item)];
    }
    else {
      print("request failed");
      return null;
    }
  }
  Future<List<Project>?> getProjects() async {
    var response = await _dio.get(_baseUrl + "/projects");

    if (response.statusCode == 200) {
      return [for (var item in response.data) Project.fromJson(item)];
    }
    else {
      print("request failed");
      return null;
    }
  }

  Future<bool> insertTimeEntry(TimeEntry entry) async {
    var response = await _dio.post(_baseUrl + "/entries", data: entry.toJson());

    print("Data inserted");
    return response.statusCode == 200;
  }

}