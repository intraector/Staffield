import 'package:flutter/foundation.dart';
import 'package:Staffield/utils/string_utils.dart';

String formatInputCurrency(
    {@required String newValue,
    @required String oldValue,
    @required int maxLength,
    bool separateThousands = false}) {
  newValue = newValue.removeTrailingDots();
  if (newValue.startsWith('.')) newValue = '0' + newValue;
  if (separateThousands) {
    var chunks = newValue.split('.');
    chunks[0] = chunks[0].separateThousands();
    newValue = chunks.join('.');
  }
  return (newValue.length <= maxLength) ? newValue : oldValue;
}
