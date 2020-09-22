import 'package:Staffield/core/entities/period_report.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jiffy/jiffy.dart';
import 'package:print_color/print_color.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class ChartData {
  ChartData(List<PeriodReport> periodReports) {
    periodReports.forEach((element) {
      Print.yellow('||| element : $element');
    });
    periodReports.sort((a, b) => a.periodTimestamp.compareTo(b.periodTimestamp));

    var firstDate = Jiffy(DateTime.fromMillisecondsSinceEpoch(periodReports.first.periodTimestamp));
    var lastDate = Jiffy(DateTime.fromMillisecondsSinceEpoch(periodReports.last.periodTimestamp));
    var difference = lastDate.diff(firstDate, Units.MONTH);

    Print.cyan('||| difference : $difference');

    int iteratorMonth = firstDate.month;
    int iteratorYear = firstDate.year;
    for (double i = 0; i <= difference; i++) {
      var bv = BottomValue(value: i, month: iteratorMonth, year: iteratorYear);
      bottomValues.add(bv);
      if (iteratorMonth < 12) {
        iteratorMonth++;
      } else {
        iteratorMonth = 0;
        iteratorYear++;
      }
    }
    for (var periodReport in periodReports) {
      var date = Jiffy(DateTime.fromMillisecondsSinceEpoch(periodReport.periodTimestamp));
      var bv = bottomValues.firstWhere(
          (item) => (item.month == date.month && item.year == date.year),
          orElse: () => BottomValue());
      bv.periodReports[periodReport.employeeUid] = FlSpot(bv.value, periodReport.total);
    }

    Set<String> employees = periodReports.map<String>((item) => item.employeeUid).toSet();

    employees.forEach((uid) {
      spots[uid] = [];
      for (var bv in bottomValues) {
        if (bv.periodReports[uid] != null) {
          spots[uid].add(bv.periodReports[uid]);
        }
      }
    });
  }

  Map<String, List<FlSpot>> spots = {};
  var sideValues = <double>[];
  var bottomValues = <BottomValue>[];
  var timestamps = <int>[];
}

class BottomValue {
  BottomValue({this.value, this.month, this.year}) {
    if (month != null && year != null) this.title = Jiffy(DateTime(year, month)).MMM;
  }
  double value;
  int month;
  int year;
  String title;
  Map<String, FlSpot> periodReports = {};
  @override
  String toString() {
    return '| value: $value, month: $month, title: $title, year: $year, periodReports: ${periodReports.keys.length} ';
  }
}
