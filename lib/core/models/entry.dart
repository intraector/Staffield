import 'package:Staffield/core/models/entry_report.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:uuid_type/uuid_type.dart';

class Entry {
  Entry();

  Entry.fromSqlite(Map<String, dynamic> json) {
    uid = json[SqliteFieldsEntries.uid];
    timestamp = json[SqliteFieldsEntries.timestamp];
    employeeUid = json[SqliteFieldsEntries.employeeUid];
    total = json[SqliteFieldsEntries.total];
    revenue = json[SqliteFieldsEntries.revenue];
    wage = json[SqliteFieldsEntries.wage];
    interest = json[SqliteFieldsEntries.interest];
  }

  double bonusAux = 0;
  String employeeNameAux = '';
  String employeeUid = '';
  double interest = 0;
  var penalties = <Penalty>[];
  double penaltiesTotalAux = 0;
  double revenue = 0;
  int timestamp;
  double total = 0;
  String uid = TimeBasedUuidGenerator().generate().toString();
  double wage = 0;

  //-----------------------------------------
  @override
  String toString() =>
      'uid: $uid, employeeName: $employeeNameAux, employeeUid: $employeeUid, total: $total, revenue: $revenue, wage: $wage, interest: $interest';

  //-----------------------------------------
  EntryReport get report => EntryReport.fromEntry(this);

  //-----------------------------------------
  Map<String, dynamic> toSqlite() => {
        SqliteFieldsEntries.uid: uid,
        SqliteFieldsEntries.timestamp: timestamp ?? DateTime.now().millisecondsSinceEpoch,
        SqliteFieldsEntries.employeeUid: employeeUid,
        SqliteFieldsEntries.total: total,
        SqliteFieldsEntries.revenue: revenue,
        SqliteFieldsEntries.wage: wage,
        SqliteFieldsEntries.interest: interest,
      };
}
