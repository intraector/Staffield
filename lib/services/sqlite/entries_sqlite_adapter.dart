import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entities/penalty.dart';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/core/entities/entry.dart';
import 'package:Staffield/services/sqlite/sqlite_convert.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_entries.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class EntriesSqliteAdapater implements EntriesRepositoryInterface {
  var _srvcSqliteEntries = Get.find<EntriesSqliteSrvc>();
  var _employeesRepo = Get.find<EmployeesRepository>();

  //-----------------------------------------
  @override
  Future<List<Entry>> fetch(
      {int greaterThan, int lessThan, List<Employee> employees, int limit}) async {
    var futureEntriesMaps = _srvcSqliteEntries.fetchEntries(
      greaterThan: greaterThan,
      lessThan: lessThan,
      employeeUids: employees?.map((employee) => employee.uid)?.toList(),
      limit: limit,
    );

    var futurePenaltiesMaps = _srvcSqliteEntries.fetchPenalties(
      greaterThan: greaterThan,
      lessThan: lessThan,
      parentUid: null,
      limit: null,
    );
    List<Entry> entries;
    var futureEntries = Future<List<Entry>>(() {
      return futureEntriesMaps.then((value) {
        return entries = value.map((entryMap) => SqliteConvert.mapToEntry(entryMap)).toList();
      });
    });
    List<Penalty> penalties;
    var futurePenalties = Future<Iterable<Penalty>>(() {
      return futurePenaltiesMaps.then((value) {
        return penalties =
            value.map((penaltyMap) => SqliteConvert.mapToPenalty(penaltyMap)).toList();
      });
    });

    return Future.wait([futureEntries, futurePenalties]).then((_) {
      var args = ComputeArgs(
        entries: entries,
        penalties: penalties,
        employeesRepo: _employeesRepo.repo,
      );
      return linkEntriesAndPenalties(args);
      // return compute<ComputeArgs, List<Entry>>(linkEntriesAndPenalties, args);
    });
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(List<Entry> entries) {
    var entriesMaps = <Map<String, dynamic>>[];
    var penaltiesMaps = <Map<String, dynamic>>[];
    for (var entry in entries) {
      entriesMaps.add(SqliteConvert.entryToMap(entry));
      penaltiesMaps.addAll(entry.penalties.map((penalty) => SqliteConvert.penaltyToMap(penalty)));
    }
    return _srvcSqliteEntries.addOrUpdate(entries: entriesMaps, penalties: penaltiesMaps);
  }

  //-----------------------------------------
  Future<void> remove(String uid) => _srvcSqliteEntries.remove(uid);
}

List<Entry> linkEntriesAndPenalties(ComputeArgs args) {
  for (var entry in args.entries) {
    var foundPenalties = args.penalties.where((penalty) => penalty.parentUid == entry.uid).toList();
    entry.penalties = foundPenalties;
    entry.employee.name =
        args.employeesRepo.firstWhere((employee) => employee.uid == entry.employee.uid).name;
  }
  return args.entries;
}

class ComputeArgs {
  ComputeArgs({
    @required this.entries,
    @required this.penalties,
    @required this.employeesRepo,
  });

  List<Entry> entries;
  List<Penalty> penalties;
  List<Employee> employeesRepo;
}
