import 'package:flutter/foundation.dart';
import 'package:Staffield/constants/penalty_type.dart';
import 'package:uuid_type/uuid_type.dart';

class Penalty {
  Penalty({@required this.type, @required this.parentUid}) {
    title = getPenaltyTitle(type);
  }

  String uid = TimeBasedUuidGenerator().generate().toString();
  String parentUid = '';
  String title = '';
  PenaltyType type;
  double total;
  int minutes;
  int money;

  //-----------------------------------------
  Penalty.fromOther(Penalty penalty) {
    uid = penalty.uid;
    parentUid = penalty.parentUid;
    title = penalty.title;
    type = penalty.type;
    total = penalty.total;
    minutes = penalty.minutes;
    money = penalty.money;
  }

  //-----------------------------------------
  Penalty.fromSqlite(Map<String, dynamic> json) {
    uid = json['uid'];
    parentUid = json['parentUid'];
    title = json['title'];
    type = json['type'];
    total = json['total'];
    minutes = json['minutes'];
    money = json['money'];
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() => {
        'uid': this.uid,
        'parentUid': this.parentUid,
        'title': this.title,
        'type': this.type,
        'total': this.total,
        'minutes': this.minutes,
        'money': this.money,
      };

  @override
  String toString() {
    return '$title $total';
  }
}
