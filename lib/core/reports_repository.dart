import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/entry_report.dart';
import 'package:Staffield/core/models/report.dart';
import 'package:Staffield/utils/month_string.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ReportsRepository {
  final _entriesRepo = getIt<EntriesRepository>();
  final _employeesRepo = getIt<EmployeesRepository>();

  //-----------------------------------------
  Future<List<EntryReport>> fetchEntriesList({
    @required DateTime greaterThan,
    @required DateTime lessThan,
    @required String employeeUid,
  }) async {
    var reports = await _entriesRepo.fetch(
      greaterThan: greaterThan.millisecondsSinceEpoch,
      lessThan: lessThan.millisecondsSinceEpoch,
      employeeUid: employeeUid,
    );
    return reports.map((entry) => entry.report).toList();
  }

  //-----------------------------------------
  Future<List<Report>> fetchByEmployee({
    @required DateTime greaterThan,
    @required DateTime lessThan,
  }) async {
    var entries = await _entriesRepo.fetch(
      greaterThan: greaterThan.millisecondsSinceEpoch,
      lessThan: lessThan.millisecondsSinceEpoch,
      employeeUid: null,
    );
    var entryReportsByEmployee = _separateByEmployee(entries);
    return entryReportsByEmployee.values.map((list) => _aggregateReport(list)).toList();
  }

  //-----------------------------------------
  Future<Map<String, Report>> fetchOneEmployeeByMonth({
    @required DateTime greaterThan,
    @required DateTime lessThan,
    @required String employeeUid,
  }) async {
    var entries = await _entriesRepo.fetch(
      greaterThan: greaterThan.millisecondsSinceEpoch,
      lessThan: lessThan.millisecondsSinceEpoch,
      employeeUid: employeeUid,
    );
    var entryReportsByMonth = _separateByMonth(entries);
    return entryReportsByMonth.map((month, items) => MapEntry(month, _aggregateReport(items)));
  }

  //-----------------------------------------
  Map<String, List<EntryReport>> _separateByEmployee(List<Entry> entries) {
    Map<String, List<EntryReport>> entryReportsByEmployee = {};
    var employees = _employeesRepo.repo;
    for (var employee in employees) {
      var result = entries
          .where((entry) => entry.employeeUid == employee.uid)
          .map((entry) => entry.report)
          .toList();
      if (result.isNotEmpty) entryReportsByEmployee[employee.uid] = result;
    }
    return entryReportsByEmployee;
  }

  //-----------------------------------------
  Map<String, List<EntryReport>> _separateByMonth(List<Entry> entries) {
    Map<String, List<EntryReport>> entryReportsByMonth = {};
    if (entries.isEmpty) return entryReportsByMonth;
    int first = entries
        .reduce((current, next) => current.timestamp < next.timestamp ? current : next)
        .timestamp;
    int last = entries
        .reduce((current, next) => current.timestamp > next.timestamp ? current : next)
        .timestamp;
    int start = first;
    while (start < last) {
      var end = getEndOfMonthOf(start);
      var result = entries
          .where((entry) => (entry.timestamp >= start) && (entry.timestamp < end))
          .map((entry) => entry.report)
          .toList();
      var _startDate = DateTime.fromMillisecondsSinceEpoch(start);
      if (result.isNotEmpty)
        entryReportsByMonth['${_startDate.month.monthTitle} ${_startDate.year}'] = result;
      start = end;
    }
    return entryReportsByMonth;
  }

  //-----------------------------------------
  Report _aggregateReport(List<EntryReport> list) {
    var result = Report();
    for (var item in list) {
      result.employeeNameAux = item.employeeNameAux;
      result.revenue += item.revenue;
      result.interest += item.interest;
      result.wage += item.wage;
      result.time += item.time ?? 0.0;
      result.penaltiesTotalAux += item.penaltiesTotalAux ?? 0.0;
      result.total += item.total;
      item.penaltiesTotalByType
          .forEach((type, value) => result.penaltiesTotalByType[type] += value);
      result.penaltiesCount += item.penaltiesCount;
      result.reportsCount++;
    }
    result.revenueAverage = result.revenue / result.reportsCount;
    result.totalAverage = result.total / result.reportsCount;
    return result;
  }

  //-----------------------------------------
  int getEndOfMonthOf(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    int year = date.year;
    int month = date.month + 1;
    if (date.month == 12) {
      year = date.year + 1;
      month = 1;
    }
    return DateTime(year, month).millisecondsSinceEpoch;
  }
}
