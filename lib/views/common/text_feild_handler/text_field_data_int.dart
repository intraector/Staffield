import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_data.dart';
import 'package:flutter/services.dart';

class TextFieldHandlerInt extends TextFieldDataBase {
  TextFieldHandlerInt({
    void Function() onChange,
    void Function() onSave,
    int maxLength = 10,
    String label,
    String hint,
    String defaultValue,
  }) : super(
          // onChange: onChange,
          onSave: onSave,
          maxLength: maxLength,
          label: label,
          hint: hint,
          defaultValue: defaultValue,
        );

  int get output => int.tryParse(txtCtrl.text.removeSpaces) ?? 0;

  List<TextInputFormatter> inputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
  ];

  @override
  String validate() {
    String value = txtCtrl.text.removeSpaces;
    if (value.isEmpty)
      return 'Введите';
    else
      return null;
  }
}
