import 'package:uuid_type/uuid_type.dart';

class Employee {
  Employee({uid, this.name = '', this.hide = false})
      : this.uid = uid ?? TimeBasedUuidGenerator().generate().toString();
  String uid;
  String name;
  bool hide;

  //-----------------------------------------
  Employee.fromSqlite(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    hide = json['hide'] == 1 ? true : false;
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() {
    return {
      'uid': uid,
      'name': name,
      'hide': hide ? 1 : 0,
    };
  }

  @override
  String toString() => '$uid $name $hide';
}
