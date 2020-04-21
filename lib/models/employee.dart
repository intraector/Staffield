import 'package:uuid_type/uuid_type.dart';

class Employee {
  String uid = TimeBasedUuidGenerator().generate().toString();
  String name = '';
  bool hide = false;

  //-----------------------------------------
  Employee.fromSqlite(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    hide = json['hide'] == 1 ? true : false;
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() => {
        'uid': uid,
        'name': name,
        'hide': hide ? 1 : 0,
      };
}
