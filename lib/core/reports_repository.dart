import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/entities/entity_convert.dart';
import 'package:Staffield/core/entities/entry.dart';
import 'package:Staffield/core/entities/report.dart';
import 'package:Staffield/core/entities/period_report.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/views/reports/vmodel_view_reports.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:print_color/print_color.dart';

class ReportsRepository {
  final _entriesRepo = Get.find<EntriesRepository>();
  final _employeesRepo = Get.find<EmployeesRepository>();
  final _penaltyTypesRepo = Get.find<PenaltyTypesRepository>();

  //-----------------------------------------
  Future<List<Report>> fetchEntriesList({
    @required DateTime greaterThan,
    @required DateTime lessThan,
    @required String employeeUid,
  }) async {
    var reports = await _entriesRepo.fetch(
      greaterThan: greaterThan.millisecondsSinceEpoch,
      lessThan: lessThan.millisecondsSinceEpoch,
      employeeUid: employeeUid,
    );
    return reports.map((entry) => EntityConvert.entryToReport(entry)).toList();
  }

  //-----------------------------------------
  /// default periodsAmount = 1
  ///
  /// lessThan ??= _entriesRepo.newestTimestamp
  Future<List<PeriodReport>> fetchAllEmployees(
      {@required Units period, int periodsAmount = 1, int lessThan}) async {
    var futures = <Future>[];
    var output = <PeriodReport>[];
    lessThan ??= _entriesRepo.newestTimestamp;
    for (int i = 0; i < periodsAmount; i++) {
      var greaterThan = getFirstDayOf(lessThan, period);

      var entriesFuture = _entriesRepo.fetch(
        greaterThan: greaterThan,
        lessThan: lessThan,
        employeeUid: null,
      );
      futures.add(entriesFuture);

      var entries = await entriesFuture;
      if (entries.isNotEmpty) {
        for (var employee in _employeesRepo.repo) {
          var entriesFound = entries.where((entry) => entry.employeeUid == employee.uid).toList();
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

  //-----------------------------------------
  Future<List<PeriodReport>> fetchSingleEmployeeOverPeriod({
    @required DateTime greaterThan,
    @required DateTime lessThan,
    @required String employeeUid,
    @required Units period,
  }) async {
    Print.yellow('||| fired fetch start');
    var entries = await _entriesRepo.fetch(
      greaterThan: greaterThan.millisecondsSinceEpoch,
      lessThan: lessThan.millisecondsSinceEpoch,
      employeeUid: employeeUid,
    );
    Print.yellow('||| fired fetch end');
    var result = _aggregateByPeriod(entries, period: period);
    Print.yellow('||| aggregation finished');
    return result;
  }

  //-----------------------------------------
  List<PeriodReport> _aggregateByPeriod(List<Entry> entries, {@required Units period}) {
    var periodReports = <PeriodReport>[];
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
        periodReports.add(periodReport);
      }
      lastDayOfPeriod = firstDayOfPeriod - 1;
    }
    return periodReports;
  }

  //-----------------------------------------
  int getFirstDayOf(int timestamp, Units period) =>
      Jiffy(DateTime.fromMillisecondsSinceEpoch(timestamp)).startOf(period).millisecondsSinceEpoch;
}
