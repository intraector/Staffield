import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/models/entry_report.dart';
import 'package:Staffield/core/models/report.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ReportsRepository {
  final _entriesRepo = getIt<EntriesRepository>();
  final _employeesRepo = getIt<EmployeesRepository>();

  //-----------------------------------------
  Future<List<Report>> fetch(DateTime startDate, DateTime endDate) async {
    var entries = await _entriesRepo.fetch(start: startDate, end: endDate);
    var employees = _employeesRepo.repo;
    Map<String, List<EntryReport>> report = {};
    for (var employee in employees) {
      var result = entries
          .where((entry) => entry.employeeUid == employee.uid)
          .map((entry) => entry.report)
          .toList();
      if (result.isNotEmpty) report[employee.uid] = result;
    }
    return report.values.map((list) => _generateReport(list)).toList();
  }

  //-----------------------------------------
  Report _generateReport(List<EntryReport> list) {
    var result = Report();
    for (var item in list) {
      result.employeeNameAux = item.employeeNameAux;
      result.revenue += item.revenue;
      result.interest += item.interest;
      result.wage += item.wage;
      result.minutes += item.minutes ?? 0.0;
      result.penaltiesTotalAux += item.penaltiesTotalAux ?? 0.0;
      result.total += item.total;
      item.penaltiesTotalByType
          .forEach((type, value) => result.penaltiesTotalByType[type] += value);
      result.reportsCount++;
    }
    result.revenueAverage = result.revenue / result.reportsCount;
    result.totalAverage = result.total / result.reportsCount;
    return result;
  }
}
