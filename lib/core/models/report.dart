import 'package:Staffield/constants/penalty_type.dart';
import 'package:Staffield/core/models/entry_report.dart';

class Report extends EntryReport {
  Report() {
    PenaltyType.values.forEach((value) => penaltiesTotalByType[value] = 0.0);
  }
  int reportsCount = 0;
  double revenueAverage;
  double totalAverage;
}
