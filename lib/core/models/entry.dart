import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/core/models/entry_report.dart';
import 'package:uuid_type/uuid_type.dart';

class Entry {
  Entry();
  String uid = TimeBasedUuidGenerator().generate().toString();
  int timestamp;
  String employeeUid = '';
  String employeeNameAux = '';
  double revenue = 0;
  double interest = 0;
  double wage = 0;
  double total = 0;
  double penaltiesTotalAux = 0;
  var penalties = <Penalty>[];

  //-----------------------------------------
  Entry.fromSqlite(Map<String, dynamic> json) {
    uid = json['uid'];
    timestamp = json['timestamp'];
    employeeUid = json['employeeUid'];
    total = json['total'];
    revenue = json['revenue'];
    wage = json['wage'];
    interest = json['interest'];
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() => {
        'uid': uid,
        'timestamp': timestamp,
        'employeeUid': employeeUid,
        'total': total,
        'revenue': revenue,
        'wage': wage,
        'interest': interest,
      };

  //-----------------------------------------
  EntryReport get report => EntryReport.fromEntry(this);

  //-----------------------------------------
  @override
  String toString() =>
      'uid: $uid, employeeName: $employeeNameAux, employeeUid: $employeeUid, total: $total, revenue: $revenue, wage: $wage, interest: $interest';
}
