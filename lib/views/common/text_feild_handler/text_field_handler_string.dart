import 'package:Staffield/views/common/text_feild_handler/text_field_handler_base.dart';

class TextFieldHandlerString extends TextFieldHandlerBase {
  TextFieldHandlerString({
    void Function() callback,
    int maxLength = 40,
    String label,
    String hint,
  }) : super(
          callback: callback,
          maxLength: maxLength,
          label: label,
          hint: hint,
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
