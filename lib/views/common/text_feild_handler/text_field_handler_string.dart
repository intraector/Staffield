import 'package:Staffield/views/common/text_feild_handler/text_field_handler_base.dart';

class TextFieldHandlerString extends TextFieldHandlerBase {
  TextFieldHandlerString({
    void Function() onChange,
    void Function() onSave,
    int maxLength = 40,
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

  String get result => txtCtrl.text.trim();

  String validate() {
    String value = txtCtrl.text.trim();
    if (value.isEmpty)
      return 'Введите';
    else {
      return null;
    }
  }
}
