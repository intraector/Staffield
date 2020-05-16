import 'package:Staffield/core/models/entry_report.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/utils/time_and_difference.dart';
import 'package:Staffield/utils/string_utils.dart';

class AdaptedEntryReport {
  AdaptedEntryReport.from(EntryReport report) {
    uid = report.uid;
    date = timeAndDifference(timestamp1: report.timestamp, showDate: true);
    report.timestamp.toString();
    name = report.employeeName;
    total = report.total.toString().formatDouble.noDotZero;
    revenue = report.revenue.toString().formatDouble.noDotZero;
    interest = report.interest.toString().formatDouble.noDotZero;
    bonus = report.bonus.toString().formatDouble.noDotZero;
    wage = report.wage.toString().formatDouble.noDotZero;
    penaltiesTotal = report.penaltiesTotalAux.toString().formatDouble.noDotZero;
    penalties = report.penalties.map((penalty) => penalty.report).toList();
    penaltyUnit = report.penaltyUnit.toString().formatDouble.noDotZero;
    penaltiesCount = report.penaltiesCount.toString().formatInt;
  }
  String uid;
  String name;
  String total;
  String revenue;
  String interest;
  String bonus;
  String wage;
  String penaltiesTotal;
  String penaltiesCount;
  String date;
  String penaltyUnit;
  var penalties = <PenaltyReport>[];
  bool isDateLabel = false;

  @override
  String toString() {
    return 'penaltiesTotal: $penaltiesTotal';
  }
}
