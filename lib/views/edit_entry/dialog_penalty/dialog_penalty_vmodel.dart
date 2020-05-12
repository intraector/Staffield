import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/utils/format_input_currency.dart';
import 'package:flutter/widgets.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DialogPenaltyVModel extends ChangeNotifier {
  DialogPenaltyVModel({@required this.penalty, @required this.screenEntryVModel}) {
    _type = _penaltyTypesRepo.getType(penalty.typeUid);
    penalty.mode = _type.mode;
    if (penalty.mode == PenaltyMode.plain) {
      txtCtrlPlainSum.text = penalty.total?.toString()?.formatCurrencyDecimal() ?? '';
    } else if (penalty.mode == PenaltyMode.calc) {
      labelTotal = (penalty.total?.toString()?.formatCurrency() ?? '0.0');
      txtCtrlUnit.text = penalty.unit == 0.0 ? '' : penalty.unit.toString();
      txtCtrlCost.text = penalty.cost == 0.0 ? '' : penalty.cost.toString();
    }
  }
  PenaltyType _type;
  String get labelUnit => _type.unitTitle.toUpperCase();
  String get labelTitle => _type.title.toUpperCase();
  String labelCost = 'Цена'.toUpperCase();
  String labelTotal;
  String labelTotalPrefix = 'Сумма: '.toUpperCase();
  int maxLengthUnit = 4;
  int maxLengthCost = 4;
  int maxLengthPlainSum = 8;
  Penalty penalty;
  final ScreenEditEntryVModel screenEntryVModel;
  final txtCtrlUnit = TextEditingController();
  final txtCtrlCost = TextEditingController();
  final txtCtrlPlainSum = TextEditingController();

  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();
  var _previosInputPlainSum = '';
  var _previosInputUnit = '';
  var _previosInputCost = '';

  //-----------------------------------------
  void _calcPenaltyTotal() {
    if (txtCtrlUnit.text.isNotEmpty && txtCtrlCost.text.isNotEmpty)
      penalty.total =
          (double.tryParse(txtCtrlUnit.text) * double.tryParse(txtCtrlCost.text)).toDouble() ?? 0.0;
    else
      penalty.total = 0.0;
    labelTotal = penalty.total.toString().formatCurrency();
    notifyListeners();
  }

  //-----------------------------------------
  String validatePlainSum() {
    if (txtCtrlPlainSum.text.isEmpty)
      return 'введите сумму';
    else {
      int result = int.tryParse(txtCtrlPlainSum.text.removeSpaces) ?? 0;
      if (result > 0)
        return null;
      else
        return 'введите сумму';
    }
  }

  //-----------------------------------------
  String validateUnit() {
    String errorTxt = 'Ошибка';
    var text = txtCtrlUnit.text.removeSpaces;
    if (text.substring(text.length - 1) == '.') return errorTxt;
    double result = double.tryParse(text) ?? 0;
    return result == 0 ? errorTxt : null;
  }

  //-----------------------------------------
  String validateCost() {
    String errorTxt = 'Ошибка';
    var text = txtCtrlCost.text.removeSpaces;
    if (text.length == 0) return 'Введите';
    if (text.substring(text.length - 1) == '.') return errorTxt;
    double result = double.tryParse(text) ?? 0;
    return result == 0 ? errorTxt : null;
  }

  //-----------------------------------------
  void save() {
    if (penalty.mode == PenaltyMode.plain)
      penalty.total = double.tryParse(txtCtrlPlainSum.text.removeSpaces) ?? 0;
    else if (penalty.mode == PenaltyMode.calc) {
      penalty.total = double.tryParse(txtCtrlUnit.text.removeSpaces) *
              double.tryParse(txtCtrlCost.text.removeSpaces) ??
          0.0;
      penalty.unit = double.tryParse(txtCtrlUnit.text.removeSpaces) ?? 0;
      penalty.cost = double.tryParse(txtCtrlCost.text.removeSpaces) ?? 0.0;
    }
  }

  //-----------------------------------------
  void formatPlainSum() {
    var result = formatInputCurrency(
      newValue: txtCtrlPlainSum.text,
      oldValue: _previosInputPlainSum,
      maxLength: maxLengthPlainSum,
      separateThousands: true,
    );
    txtCtrlPlainSum.value = TextEditingValue(
      text: result,
      composing: TextRange.empty,
      selection: TextSelection.collapsed(offset: result.length),
    );
    _previosInputPlainSum = result;
  }

  //-----------------------------------------
  void formatUnitAndCalcTotal() {
    var result = formatInputCurrency(
      newValue: txtCtrlUnit.text,
      oldValue: _previosInputUnit,
      maxLength: maxLengthUnit,
      separateThousands: true,
    );
    txtCtrlUnit.value = TextEditingValue(
      text: result,
      composing: TextRange.empty,
      selection: TextSelection.collapsed(offset: result.length),
    );
    _previosInputUnit = result;
    _calcPenaltyTotal();
  }

  //-----------------------------------------
  void formatCostAndCalcTotal() {
    var result = formatInputCurrency(
      newValue: txtCtrlCost.text,
      oldValue: _previosInputCost,
      maxLength: maxLengthCost,
      separateThousands: true,
    );
    txtCtrlCost.value = TextEditingValue(
      text: result,
      composing: TextRange.empty,
      selection: TextSelection.collapsed(offset: result.length),
    );
    _previosInputCost = result;
    _calcPenaltyTotal();
  }

  //-----------------------------------------
  void remove() {
    screenEntryVModel.removePenalty(penalty);
  }
}
