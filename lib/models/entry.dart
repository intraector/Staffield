import 'package:staff_time/models/penalty.dart';
import 'package:uuid_type/uuid_type.dart';

class Entry {
  Entry();
  String uid = TimeBasedUuidGenerator().generate().toString();
  int timestamp;
  String name = '';
  double revenue;
  double wage;
  double interest;
  var penalties = <Penalty>[];

  //-----------------------------------------
  Entry.fromSqlite(Map<String, dynamic> json) {
    uid = json['uid'];
    timestamp = json['timestamp'];
    name = json['name'];
    revenue = json['revenue'];
    wage = json['wage'];
    interest = json['interest'];
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() => {
        'uid': this.uid,
        'timestamp': this.timestamp,
        'name': this.name,
        'revenue': this.revenue,
        'wage': this.wage,
        'interest': this.interest,
      };
}
