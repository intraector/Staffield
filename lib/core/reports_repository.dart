import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/entry_report.dart';
import 'package:Staffield/core/models/report.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:jiffy/jiffy.dart';

final getIt = GetIt.instance;

class ReportsRepository {
  final _entriesRepo = getIt<EntriesRepository>();
  final _employeesRepo = getIt<EmployeesRepository>();
  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();

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
  /// default periodsAmount = 1
  ///
  /// lessThan ??= _entriesRepo.newestTimestamp
  Future<List<Report>> fetchAllEmployees(
      {@required Units period, int periodsAmount = 1, int lessThan}) async {
    var futures = <Future>[];
    var output = <Report>[];
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
  Future<List<Report>> fetchSingleEmployeeOverPeriod({
    @required DateTime greaterThan,
    @required DateTime lessThan,
    @required String employeeUid,
    @required Units period,
  }) async {
    var entries = await _entriesRepo.fetch(
      greaterThan: greaterThan.millisecondsSinceEpoch,
      lessThan: lessThan.millisecondsSinceEpoch,
      employeeUid: employeeUid,
    );
    var result = _aggregateByPeriod(entries, period: period);
    return result;
  }

  //-----------------------------------------
  List<Report> _aggregateByPeriod(List<Entry> entries, {@required Units period}) {
    var reportsOverPeriod = <Report>[];
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
          .map((entry) => entry.report)
          .toList();
      if (result.isNotEmpty) {
        reportsOverPeriod.add(Report(
          result,
          types: _penaltyTypesRepo.repo,
          period: period,
          periodTimestamp: firstDayOfPeriod,
        ));
      }
      lastDayOfPeriod = firstDayOfPeriod - 1;
    }
    return reportsOverPeriod;
  }

  //-----------------------------------------
  int getFirstDayOf(int timestamp, Units period) =>
      Jiffy(DateTime.fromMillisecondsSinceEpoch(timestamp)).startOf(period).millisecondsSinceEpoch;
}
