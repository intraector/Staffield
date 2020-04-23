import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/models/entry.dart';
import 'package:Staffield/models/penalty.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_entries.dart';
import 'package:print_color/print_color.dart';

class SqliteEntriesAdapater implements EntriesRepositoryInterface {
  var _srvcSqliteEntries = SrvcSqliteEntries();
  var _employeesRepo = getIt<EmployeesRepository>();

  //-----------------------------------------
  @override
  Future<List<Entry>> fetch() async {
    var entriesMaps = await _srvcSqliteEntries.fetchEntries();
    var penaltiesFuture = _srvcSqliteEntries.fetchPenalties();
    var result = entriesMaps.map((entryMap) => Entry.fromSqlite(entryMap)).toList();
    var penalties = (await penaltiesFuture).map((penaltyMap) => Penalty.fromSqlite(penaltyMap));
    for (var entry in result) {
      var foundPenalties = penalties.where((penalty) => penalty.parentUid == entry.uid).toList();
      entry.penalties = foundPenalties;
      entry.employeeName = _employeesRepo.getEmployee(entry.employeeUid).name;
      Print.yellow('||| entry.employeeName : ${entry.employeeName}');
    }
    return result;
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(Entry entry) async {
    if (entry.timestamp == null) entry.timestamp = DateTime.now().millisecondsSinceEpoch;
    return _srvcSqliteEntries.addOrUpdate(entry.toSqlite());
  }

  //-----------------------------------------
  Future<void> remove(String uid) => _srvcSqliteEntries.remove(uid);
}
