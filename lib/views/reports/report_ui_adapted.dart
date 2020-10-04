import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entities/report.dart';
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
    total = report.total.toString().formatAsCurrency() ?? '';
    revenue = report.revenue.toString().formatAsCurrency() ?? '';
    interest = report.interest.toString().formatAsCurrency() ?? '';
    bonus = report.bonus.toString().formatAsCurrency() ?? '';
    wage = report.wage.toString().formatAsCurrency() ?? '';
    penaltiesTotal = report.penaltiesTotal.toString().formatAsCurrency() ?? '';
    penaltyUnits = report.penaltyUnits.toString().formatAsCurrency() ?? '';
    penaltiesCount = report.penaltiesCount.toString().formatAsCurrency() ?? '';
    // penalties = report.penalties.map((penalty) => penalty.strings).toList();
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
  String penaltyUnits;
  // var penalties = <PenaltyStrings>[];
  bool isDateLabel = false;

  @override
  String toString() {
    return 'wage: $wage, bonus: $bonus, penaltiesTotal: $penaltiesTotal';
  }
}
