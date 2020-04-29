import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/models/report.dart';
import 'package:Staffield/views/reports/report_adatpted_mixin_time_by_money.dart';
import 'package:Staffield/utils/string_utils.dart';

class ReportByEmployee with TimeByMoneyAdapted {
  ReportByEmployee(Report report) {
    name = report.employeeNameAux;
    total = report.total.toString().formatCurrencyDecimal();
    totalAverage = report.totalAverage.toString().formatCurrencyDecimal();
    reportsCount = report.reportsCount.toString();
    revenue = report.revenue.toString().formatCurrencyDecimal();
    revenueAverage = report.revenueAverage.toString().formatCurrencyDecimal();
    penaltiesTotal = report.penaltiesTotalAux.toString().formatCurrencyDecimal();
    report.penaltiesTotalByType
        .forEach((type, value) => penalties[type.title] = value.toString().formatCurrencyDecimal());
    minutes = report.time.toString().formatCurrencyDecimal();
    penaltiesCount = report.penaltiesCount.toString().formatCurrencyDecimal();
  }
  String name;
  String total;
  String reportsCount;
  String revenue;
  String revenueAverage;
  String totalAverage;
  String penaltiesTotal;
  String penaltiesCount;
  Map<String, String> penalties = {};
}
