import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_entries.dart';
import 'package:flutter/foundation.dart';
import 'package:print_color/print_color.dart';

class SqliteEntriesAdapater implements EntriesRepositoryInterface {
  var _srvcSqliteEntries = SrvcSqliteEntries();
  var _employeesRepo = getIt<EmployeesRepository>();

  //-----------------------------------------
  @override
  Future<List<Entry>> fetch({
    @required int start,
    @required int end,
    @required String employeeUid,
  }) async {
    var entriesMaps =
        await _srvcSqliteEntries.fetchEntries(start: start, end: end, employeeUid: employeeUid);
    var penaltiesFuture = _srvcSqliteEntries.fetchPenalties(start: start, end: end);
    var result = entriesMaps.map((entryMap) => Entry.fromSqlite(entryMap)).toList();
    var penalties = (await penaltiesFuture).map((penaltyMap) => Penalty.fromSqlite(penaltyMap));
    for (var entry in result) {
      var foundPenalties = penalties.where((penalty) => penalty.parentUid == entry.uid).toList();
      entry.penalties = foundPenalties;
      entry.employeeNameAux = _employeesRepo.getEmployee(entry.employeeUid).name;
    }
    return result;
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(Entry entry) => _srvcSqliteEntries.addOrUpdate(
      entry: entry.toSqlite(), penalties: entry.penalties.map((penalty) => penalty.toSqlite()));

  //-----------------------------------------
  Future<void> remove(String uid) => _srvcSqliteEntries.remove(uid);
}
