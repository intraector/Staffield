import 'package:Staffield/core/models/report.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ReportByEmployee {
  ReportByEmployee(Report report) {
    name = report.employeeNameAux;
    total = report.total.toString().formatInt;
    totalAverage = report.totalAverage.toString().formatInt;
    reportsCount = report.reportsCount.toString();
    revenue = report.revenue.toString().formatInt;
    revenueAverage = report.revenueAverage.toString().formatInt;
    penaltiesTotal = report.penaltiesTotalAux.toString().formatInt;
    report.penaltiesTotalByType.forEach((typeId, value) =>
        penalties[_penaltyTypesRepo.getType(typeId).title] = value.toString().formatInt);
    penaltyUnit = report.penaltyUnit.toString().formatInt;
    penaltiesCount = report.penaltiesCount.toString().formatInt;
  }
  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();

  String name;
  String total;
  String reportsCount;
  String revenue;
  String revenueAverage;
  String totalAverage;
  String penaltiesTotal;
  String penaltiesCount;
  String penaltyUnit;
  Map<String, String> penalties = {};
}
