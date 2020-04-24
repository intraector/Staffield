import 'package:Staffield/models/penalty.dart';
import 'package:uuid_type/uuid_type.dart';

class Entry {
  Entry();
  String uid = TimeBasedUuidGenerator().generate().toString();
  int timestamp;
  String employeeUid = '';
  String employeeName = '';
  double total = 0;
  double revenue = 0;
  double wage = 0;
  double interest = 0;
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
  @override
  String toString() =>
      'uid: $uid, employeeName: $employeeName, employeeUid: $employeeUid, total: $total, revenue: $revenue, wage: $wage, interest: $interest';
}
