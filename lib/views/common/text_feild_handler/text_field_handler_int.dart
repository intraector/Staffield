import 'package:Staffield/views/common/text_feild_handler/mixin_format.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_base.dart';
import 'package:flutter/services.dart';

class TextFieldHandlerInt extends TextFieldHandlerBase with Format {
  TextFieldHandlerInt({
    void Function() onChange,
    void Function() onSave,
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

  int get result => int.tryParse(txtCtrl.text.removeSpaces) ?? 0;

  List<TextInputFormatter> inputFormatters = [WhitelistingTextInputFormatter.digitsOnly];

  @override
  String validate() {
    String value = txtCtrl.text.removeSpaces;
    if (value.isEmpty)
      return 'Введите';
    else
      return null;
  }
}
