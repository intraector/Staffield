import 'package:flutter/foundation.dart';
import 'package:uuid_type/uuid_type.dart';

class Penalty {
  Penalty({@required this.parentUid, @required this.typeUid, this.mode});

  String mode;
  String parentUid = '';
  int timestamp;
  double units;
  double cost;
  double total;
  String typeUid;
  String uid = TimeBasedUuidGenerator().generate().toString();

  //-----------------------------------------
  Penalty.copy(Penalty penalty) {
    uid = penalty.uid;
    parentUid = penalty.parentUid;
    mode = penalty.mode;
    typeUid = penalty.typeUid;
    timestamp = penalty.timestamp;
    total = penalty.total;
    units = penalty.units;
    cost = penalty.cost;
  }

  //-----------------------------------------
  @override
  String toString() {
    return 'mode: $mode, total: $total, units: $units, cost: $cost';
  }

  //-----------------------------------------
  // PenaltyStrings get strings => PenaltyStrings.from(this);
}

// class PenaltyStrings {
//   PenaltyStrings.from(Penalty penalty) {
//     typeUid = penalty.typeUid;
//     units = StringUtils.formatAsCurrency(penalty.units);
//     total = StringUtils.formatAsCurrency(penalty.total);
//   }

//   String typeUid;
//   String units;
//   String total;
//   String typeTitle;
//   String unitTitle;
// }
