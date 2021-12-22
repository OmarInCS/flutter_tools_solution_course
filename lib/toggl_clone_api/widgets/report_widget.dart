
import 'package:aladl_project/toggl_clone_api/model/time_entry.dart';
import 'package:aladl_project/toggl_clone_api/service/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportWidget extends StatelessWidget {
  ReportWidget({Key? key}) : super(key: key);
  late DioClient _dio;
  late Future<List<TimeEntry>?> timeEntries;

  @override
  Widget build(BuildContext context) {

    _dio = DioClient();
    timeEntries = _dio.getTimeEntries();

    return Container(
      child: FutureBuilder(
        future: timeEntries,
        builder: (context, AsyncSnapshot<List<TimeEntry>?> snapshot) {
          if (snapshot.hasData) {
            Map<String, double> chartData = Map();
            for (var entry in snapshot.data!) {
              var pn = entry.project!.projectName;
              if(chartData.containsKey(pn)) {
                chartData[pn] = chartData[pn]! + entry.endTime!.difference(entry.startTime).inMinutes / 60;
              }
              else {
                chartData[pn] = entry.endTime!.difference(entry.startTime).inMinutes / 60;
              }
            }
            return SfCircularChart(
              legend: Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap

              ),
              series: [
                PieSeries<MapEntry<String, double>, dynamic>(
                    dataSource: chartData.entries.toList(),
                    xValueMapper: (MapEntry<String, double> datum, index) => datum.key,
                    yValueMapper: (MapEntry<String, double> datum, index) => datum.value,
                    dataLabelSettings: DataLabelSettings(
                      // Renders the data label
                        isVisible: true,
                        textStyle: TextStyle(
                            fontSize: 20
                        )
                    )
                )
              ],
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
