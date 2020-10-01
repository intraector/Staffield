import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/entities/entity_convert.dart';
import 'package:Staffield/core/entities/entry.dart';
import 'package:Staffield/core/entities/report.dart';
import 'package:Staffield/core/entities/period_report.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class ReportsRepository {
  final _entriesRepo = Get.find<EntriesRepository>();
  final _employeesRepo = Get.find<EmployeesRepository>();
  final _penaltyTypesRepo = Get.find<PenaltyTypesRepository>();

  //-----------------------------------------
  Future<List<Report>> fetchEntriesList({
    @required DateTime greaterThan,
    @required DateTime lessThan,
    @required List<Employee> employees,
  }) async {
    var reports = await _entriesRepo.fetch(
      greaterThan: greaterThan.millisecondsSinceEpoch,
      lessThan: lessThan.millisecondsSinceEpoch,
      employees: employees,
    );
    return reports.map((entry) => EntityConvert.entryToReport(entry)).toList();
  }

  //-----------------------------------------
  /// default periodsAmount = 1
  ///
  /// lessThan ??= _entriesRepo.newestTimestamp
  Future<List<PeriodReport>> fetch({
    @required Units period,
    List<Employee> employees,
    int periodsAmount = 1,
    DateTime startDate,
  }) async {
    var futures = <Future>[];
    var output = <PeriodReport>[];
    if (_entriesRepo.cache.isEmpty) return output;
    int lessThan = startDate?.millisecondsSinceEpoch ?? _entriesRepo.newestTimestamp;
    for (int i = 0; i < periodsAmount; i++) {
      var greaterThan = getFirstDayOf(lessThan, period);
      var entriesFuture = _entriesRepo.fetch(
        greaterThan: greaterThan,
        lessThan: lessThan,
        employees: employees,
      );
      futures.add(entriesFuture);
      var entries = await entriesFuture;
      if (entries.isNotEmpty) {
        List<Employee> employeesList;
        if (employees == null || employees.isNull) {
          employeesList = _employeesRepo.repo;
        } else {
          employeesList = employees;
        }
        for (var employee in employeesList) {
          var entriesFound = entries.where((entry) => entry.employee.uid == employee.uid).toList();
          if (entriesFound.isNotEmpty) {
            output.addAll(_aggregateByPeriod(entriesFound, period: period));
          }
        }
      }

      lessThan = greaterThan - 1;
    }

    await Future.wait(futures);

    return output;
  }

  // //-----------------------------------------
  // Future<List<PeriodReport>> fetchSingleEmployeeOverPeriod({
  //   @required DateTime greaterThan,
  //   @required DateTime lessThan,
  //   @required List<String> employeeUid,
  //   @required Units period,
  // }) async {
  //   return Future<List<PeriodReport>>(() {
  //     var entries = _entriesRepo.fetch(
  //       greaterThan: greaterThan.millisecondsSinceEpoch,
  //       lessThan: lessThan.millisecondsSinceEpoch,
  //       employeeUid: employeeUid,
  //     );
  //     var list = entries.then((value) {
  //       var result = _aggregateByPeriod(value, period: period);
  //       return result;
  //     });
  //     return list;
  //   });
  // }

  //-----------------------------------------
  List<PeriodReport> _aggregateByPeriod(List<Entry> entries, {@required Units period}) {
    var output = <PeriodReport>[];
    if (entries.isEmpty) return [];
    int newest = entries
        .reduce((current, next) => current.timestamp > next.timestamp ? current : next)
        .timestamp;
    int oldest = entries
        .reduce((current, next) => current.timestamp < next.timestamp ? current : next)
        .timestamp;
    int lastDayOfPeriod = newest;
    while (lastDayOfPeriod >= oldest) {
      var firstDayOfPeriod = getFirstDayOf(lastDayOfPeriod, period);
      var result = entries
          .where((entry) =>
              (entry.timestamp <= lastDayOfPeriod) && (entry.timestamp >= firstDayOfPeriod))
          .map((entry) => EntityConvert.entryToReport(entry))
          .toList();
      if (result.isNotEmpty) {
        var periodReport = PeriodReport(
          result,
          types: _penaltyTypesRepo.repo,
          period: period,
          periodTimestamp: firstDayOfPeriod,
        );
        output.add(periodReport);
      }
      lastDayOfPeriod = firstDayOfPeriod - 1;
    }
    return output;
  }

  //-----------------------------------------
  int getFirstDayOf(int timestamp, Units period) =>
      Jiffy(DateTime.fromMillisecondsSinceEpoch(timestamp)).startOf(period).millisecondsSinceEpoch;
}
