import 'package:flutter/services.dart';
import 'package:Staffield/utils/string_utils.dart';

///degault: maxLength = 30
class MoneyFormatter extends TextInputFormatter {
  MoneyFormatter({this.maxLength = 30, this.decimals = 0});
  final int maxLength;
  final int decimals;
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    print('---------- {oldValue.selection.extentOffset} : ${oldValue.selection.extentOffset}');
    print('---------- {newValue.selection.extentOffset} : ${newValue.selection.extentOffset}');
    // print('---------- oldValue : ${oldValue.text}');
    String output = newValue.text;
    output = newValue.text.formatAsCurrency(decimals: decimals);
    print('---------- output length : ${output.length}');
    var result = TextEditingValue(
        text: output,
        composing: TextRange.collapsed(output.length),
        selection: TextSelection(baseOffset: 6, extentOffset: 6));
    print('---------- {result.selection.extentOffset} : ${result.selection.extentOffset}');
    return result;
  }
}
