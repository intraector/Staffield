import 'package:Staffield/views/common/text_feild_handler/text_field_handler_double.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_string.dart';
import 'package:Staffield/views/edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewCalcVModel extends ChangeNotifier {
  ViewCalcVModel(this.parentVModel) {
    this.title = TextFieldHandlerString(
      label: 'НАЗВАНИЕ ШАБЛОНА',
      hint: 'Например, "Бой посуды"',
      defaultValue: parentVModel.type.title,
      onChange: notifyListeners,
      onSave: save,
    );
    this.unitLabel = TextFieldHandlerString(
      label: 'НАЗВАНИЕ',
      hint: 'Например, шт. или мин.',
      defaultValue: parentVModel.type.unitTitle,
      onChange: notifyListeners,
      onSave: save,
    );
    this.unitDefault = TextFieldHandlerDouble(
      label: 'ПО УМОЛЧАНИЮ',
      defaultValue:
          parentVModel.type.unitDefaultValue?.toString()?.emptyIfZero?.noDotZero?.formatDouble,
      onChange: notifyListeners,
      onSave: save,
    );
    this.costDefault = TextFieldHandlerDouble(
      label: 'ЦЕНА ЗА ЕДИНИЦУ ПО УМОЛЧАНИЮ',
      defaultValue:
          parentVModel.type.costDefaultValue?.toString()?.emptyIfZero?.noDotZero?.formatDouble,
      onChange: notifyListeners,
      onSave: save,
    );
  }

  final ScreenEditPenaltyTypeVModel parentVModel;

  TextFieldHandlerString title;
  TextFieldHandlerString unitLabel;
  TextFieldHandlerDouble unitDefault;
  TextFieldHandlerDouble costDefault;

  String get sum => (unitDefault.result * costDefault.result).toString() ?? '';

  //-----------------------------------------
  void save() {
    parentVModel.type.title = title.result;
    parentVModel.type.unitTitle = unitLabel.result;
    parentVModel.type.unitDefaultValue = unitDefault.result;
    parentVModel.type.costDefaultValue = costDefault.result;
  }

  final String labelUnitSection = 'Единица измерения';
}
