import 'package:Staffield/utils/format_input_currency.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_base.dart';
import 'package:flutter/widgets.dart';

mixin Format on TextFieldHandlerBase {
  //-----------------------------------------
  void format() {
    var result = formatInputCurrency(
      newValue: txtCtrl.text,
      oldValue: previousInput,
      maxLength: maxLength,
      separateThousands: true,
    );
    txtCtrl.value = TextEditingValue(
      text: result,
      composing: TextRange.empty,
      selection: TextSelection.collapsed(offset: result.length),
    );
    previousInput = result;
    callback();
  }
}
