import 'package:Staffield/views/common/text_feild_handler/text_field_data_decimal.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_data_string.dart';
import 'package:Staffield/views/edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewPlainVModel extends ChangeNotifier {
  ViewPlainVModel(this.parentVModel) {
    this.title = TextFieldDataString(
      label: 'НАЗВАНИЕ ШАБЛОНА',
      hint: 'Например, "Бой посуды"',
      defaultValue: parentVModel.type.title,
      onChange: notifyListeners,
      onSave: save,
    );
    this.defaultValue = TextFieldDataDecimal(
      label: 'СУММА ПО УМОЛЧАНИЮ',
      defaultValue: parentVModel.type.costDefaultValue
          ?.toString()
          ?.emptyIfZero
          ?.noDotZero
          ?.formatAsCurrency(decimals: 2),
      onChanged: notifyListeners,
      onSave: save,
    );
  }
  final ScreenEditPenaltyTypeVModel parentVModel;
  TextFieldDataString title;
  TextFieldDataDecimal defaultValue;

  //-----------------------------------------
  void save() {
    parentVModel.type.title = title.result;
    parentVModel.type.costDefaultValue = defaultValue.value;
  }

  //-----------------------------------------
  @override
  void dispose() {
    title.txtCtrl.dispose();
    defaultValue.txtCtrl.dispose();
    super.dispose();
  }
}
