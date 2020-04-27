import 'package:Staffield/constants/penalty_type.dart';
import 'package:Staffield/core/models/report.dart';
import 'package:Staffield/views/reports/report_adatpted_mixin_time_by_money.dart';
import 'package:Staffield/utils/string_utils.dart';

class ReportAdapted with TimeByMoneyAdapted {
  ReportAdapted(Report report) {
    name = report.employeeNameAux;
    total = report.total.toString().formatCurrencyDecimal();
    totalAverage = report.totalAverage.toString().formatCurrencyDecimal();
    reportsCount = report.reportsCount.toString();
    revenue = report.revenue.toString().formatCurrencyDecimal();
    revenueAverage = report.revenueAverage.toString().formatCurrencyDecimal();
    penaltiesTotal = report.penaltiesTotalAux.toString().formatCurrencyDecimal();
    report.penaltiesTotalByType.forEach((type, value) =>
        penalties[getPenaltyTitle(type)] = value.toString().formatCurrencyDecimal());
    minutes = report.minutes.toString().formatCurrencyDecimal();
  }
  String name;
  String total;
  String reportsCount;
  String revenue;
  String revenueAverage;
  String totalAverage;
  String penaltiesTotal;
  Map<String, String> penalties = {};
}
