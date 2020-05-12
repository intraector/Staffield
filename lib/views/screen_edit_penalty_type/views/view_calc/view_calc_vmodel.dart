import 'package:Staffield/views/common/text_feild_handler/text_field_handler_double.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_string.dart';
import 'package:Staffield/views/screen_edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewCalcVModel extends ChangeNotifier {
  ViewCalcVModel(this.parentVModel) {
    this.title = TextFieldHandlerString(
      label: 'НАЗВАНИЕ ШАБЛОНА',
      hint: 'Например, "Бой посуды"',
      callback: notifyListeners,
    );
    this.unitLabel = TextFieldHandlerString(
      label: 'НАЗВАНИЕ',
      hint: 'Например, "Штуки"',
      callback: notifyListeners,
    );
    this.unitDefault = TextFieldHandlerDouble(
      label: 'ПО УМОЛЧАНИЮ',
      callback: notifyListeners,
    );
    this.costDefault = TextFieldHandlerDouble(
      label: 'ЦЕНА ЗА ЕДИНИЦУ ПО УМОЛЧАНИЮ',
      callback: notifyListeners,
    );
  }

  final ScreenEditPenaltyTypeVModel parentVModel;

  TextFieldHandlerString title;
  TextFieldHandlerString unitLabel;
  TextFieldHandlerDouble unitDefault;
  TextFieldHandlerDouble costDefault;

  String get sum => (unitDefault.result * costDefault.result).toString() ?? '';

  final String labelTypeTitle = 'НАЗВАНИЕ';
  final String labelDefaultValue = 'СУММА ПО УМОЛЧАНИЮ';
  final String labelUnitSection = 'Единица измерения';
}
