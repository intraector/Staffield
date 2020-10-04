import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entities/penalty_report.dart';
import 'package:Staffield/core/entities/period_report.dart';
import 'package:Staffield/utils/string_utils.dart';

class PeriodReportUiAdapted {
  PeriodReportUiAdapted(PeriodReport report) {
    employee = report.employee;
    periodTitle = report.periodTitle;
    total = report.total.toString().formatAsCurrency();
    wage = report.wage.toString().formatAsCurrency();
    bonus = report.bonus.toString().formatAsCurrency();
    totalAverage = report.totalAvg.toString().formatAsCurrency();
    reportsCount = report.reportsCount.toString();
    revenue = report.revenue.toString().formatAsCurrency();
    revenueAverage = report.revenueAvg.toString().formatAsCurrency();
    penaltiesTotal = report.penaltiesTotal.toString().formatAsCurrency();
    penaltyUnit = report.penaltyUnits.toString().formatAsCurrency();
    penaltiesCount = report.penaltiesCount.toString().formatAsCurrency();
    periodTitle = report.periodTitle;
    penalties = report.penalties;
  }
  Employee employee;
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
