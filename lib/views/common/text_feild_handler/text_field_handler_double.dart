import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/common/text_feild_handler/mixin_format.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_base.dart';
import 'package:flutter/services.dart';

class TextFieldHandlerDouble extends TextFieldHandlerBase with Format {
  TextFieldHandlerDouble({
    void Function() onChange,
    void Function() onSave,
    this.validator,
    int maxLength = 10,
    String label,
    String hint,
    String defaultValue,
  }) : super(
          onChange: onChange,
          onSave: onSave,
          maxLength: maxLength,
          label: label,
          hint: hint,
          defaultValue: defaultValue,
        );

  String Function(String) validator;
  List<TextInputFormatter> inputFormatters = [
    FilteringTextInputFormatter.allow(regexpDigitsAndDot())
  ];

  double get result => double.tryParse(txtCtrl.text.removeSpaces) ?? 0.0;

  @override
  String validate() {
    String value = txtCtrl.text.removeSpaces;
    if (validator != null) {
      return validator(value);
    } else {
      if (value.isEmpty)
        return 'Введите';
      else if (value.endsWith('.'))
        return 'Ошибка';
      else
        return null;
    }
  }
}
