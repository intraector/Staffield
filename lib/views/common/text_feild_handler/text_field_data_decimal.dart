import 'package:Staffield/utils/money_formatter.dart';
import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_data.dart';
import 'package:flutter/services.dart';

class TextFieldDataDecimal extends TextFieldDataBase {
  TextFieldDataDecimal({
    void Function([String _]) onChanged,
    void Function([String _]) onSave,
    this.validator,
    this.maxLength = 10,
    String label,
    String hint,
    String defaultValue,
  }) : super(
          onChanged: onChanged,
          onSave: onSave,
          maxLength: maxLength,
          label: label,
          hint: hint,
          defaultValue: defaultValue,
        );

  int maxLength;

  String Function(String) validator;
  List<TextInputFormatter> inputFormatters = [
    FilteringTextInputFormatter.allow(regexpDigitsAndDot()),
    MoneyFormatter(decimals: 2, maxLength: 30)
  ];

  double get value {
    // print('---------- {txtCtrl.text} : ${txtCtrl.text.removeSpaces}');
    // print('---------- {double.tryParse} : ${double.tryParse(txtCtrl.text.removeSpaces)}');
    return double.tryParse(txtCtrl.text.removeSpaces) ?? 0.0;
  }

  @override
  String validate([String _]) {
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
