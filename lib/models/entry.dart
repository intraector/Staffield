import 'package:Staffield/models/penalty.dart';
import 'package:uuid_type/uuid_type.dart';

class Entry {
  Entry();
  String uid = TimeBasedUuidGenerator().generate().toString();
  int timestamp;
  String employeeUid = '';
  String employeeName = '';
  double revenue;
  double wage;
  double interest;
  var penalties = <Penalty>[];

  //-----------------------------------------
  Entry.fromSqlite(Map<String, dynamic> json) {
    uid = json['uid'];
    timestamp = json['timestamp'];
    employeeUid = json['employeeUid'];
    revenue = json['revenue'];
    wage = json['wage'];
    interest = json['interest'];
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() => {
        'uid': uid,
        'timestamp': timestamp,
        'employeeUid': employeeUid,
        'revenue': revenue,
        'wage': wage,
        'interest': interest,
      };
}
