import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entities/report.dart';
import 'package:Staffield/core/entities/penalty.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:jiffy/jiffy.dart';

class ReportUiAdapted {
  ReportUiAdapted.from(Report report) {
    if (report.isDateLabel) {
      isDateLabel = true;
      date = report.dateLabel;
      return;
    }
    uid = report.uid;
    date = Jiffy(DateTime.fromMillisecondsSinceEpoch(report.timestamp)).MMMMd;
    report.timestamp.toString();
    employee = report.employee;
    total = report.total.toString().formatDouble.noDotZero;
    revenue = report.revenue.toString().formatDouble.noDotZero;
    interest = report.interest.toString().formatDouble.noDotZero;
    bonus = report.bonus.toString().formatDouble.noDotZero;
    wage = report.wage.toString().formatDouble.noDotZero;
    penaltiesTotal = report.penaltiesTotal.toString().formatDouble.noDotZero;
    penalties = report.penalties.map((penalty) => penalty.strings).toList();
    penaltyUnit = report.penaltyUnits.toString().formatDouble.noDotZero;
    penaltiesCount = report.penaltiesCount.toString().formatInt;
  }
  String uid;
  Employee employee;
  String total;
  String revenue;
  String interest;
  String bonus;
  String wage;
  String penaltiesTotal;
  String penaltiesCount;
  String date;
  String penaltyUnit;
  var penalties = <PenaltyStrings>[];
  bool isDateLabel = false;

  @override
  String toString() {
    return 'penaltiesTotal: $penaltiesTotal';
  }
}
