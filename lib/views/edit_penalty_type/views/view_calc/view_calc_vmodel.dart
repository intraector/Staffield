import 'package:Staffield/views/common/text_feild_handler/text_field_data_decimal.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_data_string.dart';
import 'package:Staffield/views/edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewCalcVModel extends ChangeNotifier {
  ViewCalcVModel(this.parentVModel) {
    this.title = TextFieldDataString(
      label: 'НАЗВАНИЕ ШАБЛОНА',
      hint: 'Например, "Бой посуды"',
      defaultValue: parentVModel.type.title,
      onChange: notifyListeners,
      onSave: save,
    );
    this.unitLabel = TextFieldDataString(
      label: 'НАЗВАНИЕ',
      hint: 'Например, шт. или мин.',
      defaultValue: parentVModel.type.unitTitle,
      onChange: notifyListeners,
      onSave: save,
    );
    this.unitDefault = TextFieldDataDecimal(
      label: 'ПО УМОЛЧАНИЮ',
      defaultValue: parentVModel.type.unitDefaultValue
          ?.toString()
          ?.emptyIfZero
          ?.noDotZero
          ?.formatAsCurrency(decimals: 2),
      onChanged: notifyListeners,
      onSave: save,
    );
    this.costDefault = TextFieldDataDecimal(
      label: 'ЦЕНА ЗА ЕДИНИЦУ ПО УМОЛЧАНИЮ',
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
  TextFieldDataString unitLabel;
  TextFieldDataDecimal unitDefault;
  TextFieldDataDecimal costDefault;

  String get sum => (unitDefault.value * costDefault.value).toString() ?? '';

  //-----------------------------------------
  void save() {
    parentVModel.type.title = title.result;
    parentVModel.type.unitTitle = unitLabel.result;
    parentVModel.type.unitDefaultValue = unitDefault.value;
    parentVModel.type.costDefaultValue = costDefault.value;
  }

  final String labelUnitSection = 'Единица измерения';
}
