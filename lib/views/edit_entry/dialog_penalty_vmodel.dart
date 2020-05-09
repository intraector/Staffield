import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:print_color/print_color.dart';

final getIt = GetIt.instance;

class DialogPenaltyVModel extends ChangeNotifier {
  DialogPenaltyVModel({@required this.penalty, @required this.screenEntryVModel}) {
    _type = _penaltyTypesRepo.getType(penalty.typeUid);
    penalty.mode = _type.mode;
    if (penalty.mode == PenaltyMode.plain) {
      txtCtrlPlainSum.text = penalty.total?.toString()?.formatCurrencyDecimal() ?? '';
    } else if (penalty.mode == PenaltyMode.calc) {
      labelTotal = labelTotalPrefix + (penalty.total?.toString()?.formatCurrency() ?? '0.0');
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
  int maxLengthMinutes = 4;
  int maxLengthMoney = 4;
  int maxLengthPlainSum = 8;
  Penalty penalty;
  final ScreenEditEntryVModel screenEntryVModel;
  final txtCtrlUnit = TextEditingController();
  final txtCtrlCost = TextEditingController();
  final txtCtrlPlainSum = TextEditingController();

  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();

  //-----------------------------------------
  void calcPenaltyTimeByMoney() {
    if (txtCtrlUnit.text.isNotEmpty && txtCtrlCost.text.isNotEmpty)
      penalty.total =
          (double.tryParse(txtCtrlUnit.text) * double.tryParse(txtCtrlCost.text)).toDouble() ?? 0.0;
    else
      penalty.total = 0.0;
    labelTotal = labelTotalPrefix + penalty.total.toString().formatCurrency();
    notifyListeners();
  }

  //-----------------------------------------
  String validatePlainSum() {
    if (txtCtrlPlainSum.text.isEmpty)
      return 'введите сумму';
    else {
      int result = int.tryParse(txtCtrlPlainSum.text) ?? 0;
      if (result > 0)
        return null;
      else
        return 'введите сумму';
    }
  }

  //-----------------------------------------
  String validateMinutes() {
    int result = int.tryParse(txtCtrlUnit.text) ?? 0;
    return result == 0 ? 'введите минуты' : null;
  }

  //-----------------------------------------
  String validateMoney() => txtCtrlCost.text.isEmpty ? 'введите сумму' : null;

  //-----------------------------------------
  void save() {
    if (penalty.mode == PenaltyMode.plain)
      penalty.total = double.tryParse(txtCtrlPlainSum.text) ?? 0;
    else if (penalty.mode == PenaltyMode.calc) {
      penalty.total = double.tryParse(txtCtrlUnit.text) * double.tryParse(txtCtrlCost.text) ?? 0.0;
      penalty.unit = double.tryParse(txtCtrlUnit.text) ?? 0;
      penalty.cost = double.tryParse(txtCtrlCost.text) ?? 0.0;
    }
  }

  //-----------------------------------------
  void remove() {
    screenEntryVModel.removePenalty(penalty);
  }
}
