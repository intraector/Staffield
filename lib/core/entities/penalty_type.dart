import 'package:uuid_type/uuid_type.dart';

class PenaltyType {
  PenaltyType({this.mode});
  String uid = TimeBasedUuidGenerator().generate().toString();
  String mode;
  String title = '';
  String unitTitle = '';
  double unitDefaultValue;
  double costDefaultValue;
  bool hide = false;

  // PenaltyType get copy => PenaltyType()
  //   ..mode = mode
  //   ..title = title
  //   ..unitTitle = unitTitle
  //   ..unitDefaultValue = unitDefaultValue
  //   ..costDefaultValue = costDefaultValue
  //   ..hide = hide;

  @override
  String toString() {
    return 'id: $uid, mode: $mode, title:$title, unitTitle: $unitTitle, unitDefaultValue: $unitDefaultValue, costDefaultValue: $costDefaultValue, hide: $hide';
  }
}
