import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entities/penalty_report.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jiffy/jiffy.dart';

class PeriodValue {
  PeriodValue({this.value, this.month, this.year, bool textMode = true}) {
    if (month != null && year != null) {
      this.title = Jiffy(DateTime(year, month)).MMM;
    }
  }
  double value;
  int month;
  int year;
  String title;
  Map<Employee, FlSpot> periodReports = {};
  Map<Employee, List<PenaltyReport>> periodPenalties = {};
  @override
  String toString() {
    return '| value: $value, month: $month, title: $title, year: $year, periodReports: ${periodReports.keys.length} ';
  }
}
