// enum PenaltyType { plain, timeByMoney }

// String getPenaltyTitle(PenaltyType type) {
//   String result;
//   switch (type) {
//     case PenaltyType.plain:
//       result = 'Штраф';
//       break;
//     case PenaltyType.timeByMoney:
//       result = 'Опоздание';
//       break;
//   }
//   return result;
// }

import 'dart:math';

class PenaltyType {
  static const _types = <String, String>{'plain': 'Штраф', 'timeByMoney': 'Опоздание'};
  static const String plain = 'plain';
  static const String timeByMoney = 'timeByMoney';
  static var allTypes = _types.keys;

  static var _random = Random();

  //-----------------------------------------
  static String get random => _types.keys.elementAt(_random.nextInt(_types.length));

  //-----------------------------------------
  static String titleOf(String type) => _types[type];
}

extension TitleOfType on String {
  String get title => PenaltyType.titleOf(this);
}
