import 'package:Staffield/core/models/penalty_mixin_time_by_money.dart';
import 'package:flutter/foundation.dart';
import 'package:Staffield/constants/penalty_type.dart';
import 'package:uuid_type/uuid_type.dart';

class Penalty with TimeByMoney {
  Penalty({@required this.type, @required this.parentUid}) {
    title = getPenaltyTitle(type);
  }

  String uid = TimeBasedUuidGenerator().generate().toString();
  String parentUid = '';
  String title = '';
  PenaltyType type;
  double total;

  //-----------------------------------------
  Penalty.fromOther(Penalty penalty) {
    uid = penalty.uid;
    parentUid = penalty.parentUid;
    title = penalty.title;
    type = penalty.type;
    total = penalty.total;
    if (penalty.type == PenaltyType.minutesByMoney) {
      minutes = penalty.minutes;
      money = penalty.money;
    }
  }

  //-----------------------------------------
  Penalty.fromSqlite(Map<String, dynamic> json) {
    uid = json['uid'];
    parentUid = json['parentUid'];
    title = json['title'];
    type = json['type'];
    total = json['total'];
    if (type == PenaltyType.minutesByMoney) {
      minutes = json['minutes'];
      money = json['money'];
    }
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() {
    var result = {
      'uid': uid,
      'parentUid': parentUid,
      'title': title,
      'type': type,
      'total': total,
    };
    if (this.type == PenaltyType.minutesByMoney) {
      result['minutes'] = minutes;
      result['money'] = money;
    }
    return result;
  }

  @override
  String toString() {
    return '$title $total';
  }
}
