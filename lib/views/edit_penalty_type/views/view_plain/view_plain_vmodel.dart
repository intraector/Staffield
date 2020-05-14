import 'package:Staffield/views/common/text_feild_handler/text_field_handler_double.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_string.dart';
import 'package:Staffield/views/edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewPlainVModel extends ChangeNotifier {
  ViewPlainVModel(this.parentVModel) {
    this.title = TextFieldHandlerString(
      label: 'НАЗВАНИЕ ШАБЛОНА',
      hint: 'Например, "Бой посуды"',
      defaultValue: parentVModel.type.title,
      onChange: notifyListeners,
      onSave: save,
    );
    this.defaultValue = TextFieldHandlerDouble(
      label: 'СУММА ПО УМОЛЧАНИЮ',
      defaultValue:
          parentVModel.type.costDefaultValue?.toString()?.emptyIfZero?.noDotZero?.formatDouble,
      onChange: notifyListeners,
      onSave: save,
    );
  }
  final ScreenEditPenaltyTypeVModel parentVModel;
  TextFieldHandlerString title;
  TextFieldHandlerDouble defaultValue;

  //-----------------------------------------
  void save() {
    parentVModel.type.title = title.result;
    parentVModel.type.costDefaultValue = defaultValue.result;
  }

  //-----------------------------------------
  @override
  void dispose() {
    title.txtCtrl.dispose();
    defaultValue.txtCtrl.dispose();
    super.dispose();
  }
}
