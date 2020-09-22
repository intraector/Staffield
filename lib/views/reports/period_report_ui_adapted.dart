import 'package:Staffield/core/entities/penalty_report.dart';
import 'package:Staffield/core/entities/period_report.dart';
import 'package:Staffield/utils/string_utils.dart';

class PeriodReportUiAdapted {
  PeriodReportUiAdapted(PeriodReport report) {
    employeeName = report.employeeName;
    employeeUid = report.employeeUid;
    periodTitle = report.periodTitle;
    total = report.total.toString().formatInt;
    wage = report.wage.toString().formatInt;
    bonus = report.bonus.toString().formatInt;
    totalAverage = report.totalAverage.toString().formatInt;
    reportsCount = report.reportsCount.toString();
    revenue = report.revenue.toString().formatInt;
    revenueAverage = report.revenueAverage.toString().formatInt;
    penaltiesTotal = report.penaltiesTotal.toString().formatInt;
    penaltyUnit = report.penaltyUnit.toString().formatInt;
    penaltiesCount = report.penaltiesCount.toString().formatInt;
    periodTitle = report.periodTitle;
    penalties = report.penalties;
  }
  String employeeUid;
  String employeeName;
  String periodTitle;
  String total;
  String wage;
  String bonus;
  String reportsCount;
  String revenue;
  String revenueAverage;
  String totalAverage;
  String penaltiesTotal;
  String penaltiesCount;
  String penaltyUnit;
  var penalties = <PenaltyReport>[];
  @override
  String toString() => 'periodTitle : $periodTitle, penalties : $penalties';
}
