import 'package:Staffield/core/models/entry_report.dart';

class Report extends EntryReport {
  int reportsCount = 0;
  double revenueAverage;
  double totalAverage;

  //-----------------------------------------
  @override
  String toString() {
    return ' reportsCount: $reportsCount, penaltiesTotalByType: $penaltiesTotalByType';
  }
}
