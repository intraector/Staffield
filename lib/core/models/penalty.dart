import 'package:Staffield/core/models/penalty_mixin_time_by_money.dart';
import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:uuid_type/uuid_type.dart';

class Penalty with TimeByMoney {
  Penalty({@required this.type, @required this.parentUid}) {
    title = type.title;
  }

  String uid = TimeBasedUuidGenerator().generate().toString();
  String parentUid = '';
  String title = '';
  String type;
  int timestamp;
  double total;

  //-----------------------------------------
  Penalty.fromOther(Penalty penalty) {
    uid = penalty.uid;
    parentUid = penalty.parentUid;
    title = penalty.title;
    type = penalty.type;
    timestamp = penalty.timestamp;
    total = penalty.total;
    if (penalty.type == PenaltyType.timeByMoney) {
      time = penalty.time;
      money = penalty.money;
    }
  }

  //-----------------------------------------
  Penalty.fromSqlite(Map<String, dynamic> json) {
    uid = json[SqliteFieldsPenalties.uid];
    parentUid = json[SqliteFieldsPenalties.parentUid];
    title = PenaltyType.titleOf(json[SqliteFieldsPenalties.type]);
    type = json[SqliteFieldsPenalties.type];
    timestamp = json[SqliteFieldsPenalties.timestamp];
    total = json[SqliteFieldsPenalties.total];
    if (type == PenaltyType.timeByMoney) {
      time = json[SqliteFieldsPenalties.time];
      money = json[SqliteFieldsPenalties.money];
    }
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() {
    var result = {
      SqliteFieldsPenalties.uid: uid,
      SqliteFieldsPenalties.parentUid: parentUid,
      SqliteFieldsPenalties.type: type,
      SqliteFieldsPenalties.timestamp: timestamp ?? DateTime.now().millisecondsSinceEpoch,
      SqliteFieldsPenalties.total: total,
    };
    if (this.type == PenaltyType.timeByMoney) {
      result[SqliteFieldsPenalties.time] = time;
      result[SqliteFieldsPenalties.money] = money;
    }
    return result;
  }

  @override
  String toString() {
    return '$title $total parentUid: $parentUid timestamp: ${DateTime.fromMillisecondsSinceEpoch(timestamp)}';
  }
}
