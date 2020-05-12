import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/common/text_feild_handler/mixin_format.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_base.dart';
import 'package:flutter/services.dart';

class TextFieldHandlerDouble extends TextFieldHandlerBase with Format {
  TextFieldHandlerDouble({
    void Function() callback,
    int maxLength = 10,
    String label,
    String hint,
  }) : super(
          callback: callback,
          maxLength: maxLength,
          label: label,
          hint: hint,
        );

  List<TextInputFormatter> inputFormatters = [WhitelistingTextInputFormatter(regexpDigitsAndDot())];

  double get result => double.tryParse(txtCtrl.text.removeSpaces) ?? 0.0;

  @override
  String validate() {
    String value = txtCtrl.text.removeSpaces;
    if (value.isEmpty)
      return 'Введите';
    else if (value.endsWith('.'))
      return 'Ошибка';
    else
      return null;
  }
}
