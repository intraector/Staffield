import 'package:Staffield/core/models/report.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartData {
  ChartData(List<Report> list) {
    Set<int> _dates = {};
    for (var report in list) {
      _dates.add(report.periodTimestamp);
      if (reportsByEmployee[report.employeeName] == null) {
        reportsByEmployee[report.employeeName] = [report];
      } else {
        reportsByEmployee[report.employeeName].add(report);
      }
    }
    dates = _dates.map((e) => DateTime.fromMillisecondsSinceEpoch(e)).toList()..sort();
    generateBezierLines();
    // generateLines();
  }

  void generateBezierLines() {
    int counter = 0;
    reportsByEmployee.forEach((employeeName, reports) {
      var bLine = BezierLine(
        lineColor: counter == 0 ? Colors.purple : Colors.yellow,
        label: employeeName,
        data: reports.map((e) {
          // Print.green('|||  $employeeName, value: ${e.total}, xAxis: ${e.periodTimestamp.toDouble()}');
          return DataPoint<DateTime>(
              value: e.total, xAxis: DateTime.fromMillisecondsSinceEpoch(e.periodTimestamp));
        }).toList(),
      );
      bezierLines.add(bLine);
      counter++;
    });
  }

  // void generateLines() {
  //   reportsByEmployee.forEach((employeeName, reports) {
  //     var next = charts.Series<Report, DateTime>(
  //       id: employeeName,
  //       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
  //       domainFn: (Report report, _) => DateTime.fromMillisecondsSinceEpoch(report.periodTimestamp),
  //       measureFn: (Report report, _) => report.total,
  //       data: reports,
  //     );
  //     lines.add(next);
  //   });
  // }

  List<charts.Series<Report, DateTime>> lines = [];
  Map<String, List<Report>> reportsByEmployee = {};
  List<BezierLine> bezierLines = [];
  List<DateTime> dates;

  DateTime get first => dates.first;
  DateTime get last {
    if (dates.length > 1)
      return dates.last;
    else
      return dates.first.add(Duration(days: 1));
  }

  int minTimestamp = 0;
  int maxTimestamp = 0;
  double minRevenue = 0.0;
  double maxRevenue = 0.0;
  double minBonus = 0.0;
  double maxBonus = 0.0;
  double minTotal = 0.0;
  double maxTotal = 0.0;
}
