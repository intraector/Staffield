import 'package:Staffield/utils/format_input_currency.dart';
import 'package:Staffield/views/screen_edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Staffield/utils/string_utils.dart';

class ViewPlainVModel extends ChangeNotifier {
  ViewPlainVModel(this.parentVModel);
  final ScreenEditPenaltyTypeVModel parentVModel;

  var txtCtrlTitle = TextEditingController();
  var txtCtrlDefaultValue = TextEditingController();
  var txtCtrlExample = TextEditingController();
  final int titleMaxLength = 40;
  final int _defaultValueMaxLength = 10;
  var _defaultValuePreviosInput = '';

  //-----------------------------------------
  void formatDefaultValue() {
    var result = formatInputCurrency(
      newValue: txtCtrlDefaultValue.text,
      oldValue: _defaultValuePreviosInput,
      maxLength: _defaultValueMaxLength,
      separateThousands: true,
    );
    txtCtrlDefaultValue.value = TextEditingValue(
      text: result,
      composing: TextRange.empty,
      selection: TextSelection.collapsed(offset: result.length),
    );
    _defaultValuePreviosInput = result;
    updateScreen;
  }

  void get updateScreen => notifyListeners();

  //-----------------------------------------
  String validateTitle() {
    if (txtCtrlTitle.text.trim().isEmpty)
      return 'введите название';
    else {
      return null;
    }
  }

  //-----------------------------------------
  String validateDefaultValue() {
    if (txtCtrlDefaultValue.text.endsWith('.'))
      return 'проверьте сумму';
    else {
      parentVModel.type.costDefaultValue =
          double.tryParse(txtCtrlDefaultValue.text.removeSpaces) ?? 0.0;
      return null;
    }
  }

  final String labelTypeTitle = 'НАЗВАНИЕ';
  final String labelDefaultValue = 'СУММА ПО УМОЛЧАНИЮ';

  @override
  void dispose() {
    txtCtrlTitle.dispose();
    txtCtrlDefaultValue.dispose();
    txtCtrlExample.dispose();
    super.dispose();
  }
}
