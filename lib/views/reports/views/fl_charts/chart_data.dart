import 'dart:math';

import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entities/period_report.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/report_criteria.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:Staffield/utils/string_utils.dart';

class ChartData {
  ChartData(List<PeriodReport> periodReports, ReportCriterion criterion) {
    voidBuildData(periodReports, criterion);
  }

  Map<Employee, List<FlSpot>> spots = {};
  var bottomValues = <BottomValue>[];
  bool textMode = true;
  double maxCriterionValue = 0.0;
  double interval = 0.0;

  //----------------------------------------
  voidBuildData(List<PeriodReport> periodReports, ReportCriterion criterion) {
    if (periodReports.isEmpty) return;
    periodReports.sort((a, b) => a.periodTimestamp.compareTo(b.periodTimestamp));

    var firstDate = Jiffy(DateTime.fromMillisecondsSinceEpoch(periodReports.first.periodTimestamp));
    var lastDate = Jiffy(DateTime.fromMillisecondsSinceEpoch(periodReports.last.periodTimestamp));
    var difference = lastDate.diff(firstDate, Units.MONTH);

    int iteratorMonth = firstDate.month;
    int iteratorYear = firstDate.year;
    for (double i = 0; i <= difference; i++) {
      var bv = BottomValue(value: i, month: iteratorMonth, year: iteratorYear);
      bottomValues.add(bv);
      if (iteratorMonth < 12) {
        iteratorMonth++;
      } else {
        iteratorMonth = 1;
        iteratorYear++;
      }
    }

    for (var periodReport in periodReports) {
      var nextCriterionValue = ReportCriterionMapper.value(criterion, periodReport);
      if (maxCriterionValue < nextCriterionValue) maxCriterionValue = nextCriterionValue;
      var date = Jiffy(DateTime.fromMillisecondsSinceEpoch(periodReport.periodTimestamp));
      var bv = bottomValues.firstWhere(
          (item) => (item.month == date.month && item.year == date.year),
          orElse: () => BottomValue());
      bv.periodReports[periodReport.employee] =
          FlSpot(bv.value, ReportCriterionMapper.value(criterion, periodReport));
    }
    calcInterval();
    Set<Employee> employees = periodReports.map<Employee>((item) => item.employee).toSet();

    employees.forEach((uid) {
      spots[uid] = [];
      for (var bv in bottomValues) {
        if (bv.periodReports[uid] != null) {
          spots[uid].add(bv.periodReports[uid]);
        }
      }
    });
    if (bottomValues.length > 8) textMode = false;
  }

  //----------------------------------------
  void calcInterval() {
    interval = maxCriterionValue / 5;
    var numberOfDigits = interval.round().toString().length - 1;
    double precision = pow(10, numberOfDigits).toDouble();
    interval = (interval / precision).round().toDouble() * precision;
  }

  //----------------------------------------
  String getBottomTitle(double value) {
    var foundItem =
        bottomValues.firstWhere((element) => element.value == value, orElse: () => BottomValue());
    if (foundItem.value != null)
      return textMode ? foundItem.title : foundItem.month.toString();
    else
      return null;
  }

  //----------------------------------------
  List<LineTooltipItem> getTooltipItems(list) => list.map<LineTooltipItem>((spot) {
        return LineTooltipItem(
          spots.keys.elementAt(spot.barIndex).name + ': ' + spot.y.toString().formatInt,
          TextStyle(
            color: spots.keys.elementAt(spot.barIndex).color,
          ),
        );
      }).toList();

  //----------------------------------------
  List<LineChartBarData> get lines {
    var list = <LineChartBarData>[];
    for (var key in spots.keys) {
      list.add(
        LineChartBarData(
          spots: spots[key],
          isCurved: true,
          curveSmoothness: 0.2,
          colors: [key.color],
          barWidth: 5,
          dotData: FlDotData(show: true),
        ),
      );
    }
    return list;
  }
}

class BottomValue {
  BottomValue({this.value, this.month, this.year, bool textMode = true}) {
    if (month != null && year != null) {
      if (textMode) {
        this.title = Jiffy(DateTime(year, month)).MMM;
      } else {
        this.title = month.toString();
      }
    }
  }
  double value;
  int month;
  int year;
  String title;
  Map<Employee, FlSpot> periodReports = {};
  @override
  String toString() {
    return '| value: $value, month: $month, title: $title, year: $year, periodReports: ${periodReports.keys.length} ';
  }
}
