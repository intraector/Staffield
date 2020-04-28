import 'package:flutter/widgets.dart';
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';

class DialogPenaltyVModel extends ChangeNotifier {
  DialogPenaltyVModel({@required this.penalty, @required this.screenEntryVModel}) {
    if (penalty.type == PenaltyType.plain) {
      txtCtrlPlainSum.text = penalty.total?.toString()?.formatCurrencyDecimal() ?? '';
    } else if (penalty.type == PenaltyType.timeByMoney) {
      labelTotal = labelTotalPrefix + (penalty.total?.toString()?.formatCurrency() ?? '0.0');
      txtCtrlMinutes.text = penalty.time?.toString() ?? '';
      txtCtrlMoney.text = penalty.money?.toString() ?? '';
    }
  }
  Penalty penalty;

  final ScreenEditEntryVModel screenEntryVModel;

  final txtCtrlPlainSum = TextEditingController();
  final txtCtrlMinutes = TextEditingController();
  final txtCtrlMoney = TextEditingController();

  int maxLengthPlainSum = 8;
  int maxLengthMinutes = 4;
  int maxLengthMoney = 4;

  String labelMinutes = 'Минуты';
  String labelMoney = 'Деньги';
  String labelTotalPrefix = 'Сумма: ';
  String labelTotal;

  //-----------------------------------------
  void calcPenaltyTimeByMoney() {
    if (txtCtrlMinutes.text.isNotEmpty && txtCtrlMoney.text.isNotEmpty)
      penalty.total =
          (double.tryParse(txtCtrlMinutes.text) * double.tryParse(txtCtrlMoney.text)).toDouble() ??
              0.0;
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
    int result = int.tryParse(txtCtrlMinutes.text) ?? 0;
    return result == 0 ? 'введите минуты' : null;
  }

  //-----------------------------------------
  String validateMoney() => txtCtrlMoney.text.isEmpty ? 'введите сумму' : null;

  //-----------------------------------------
  void save() {
    if (penalty.type == PenaltyType.plain)
      penalty.total = double.tryParse(txtCtrlPlainSum.text) ?? 0;
    else if (penalty.type == PenaltyType.timeByMoney) {
      penalty.total =
          double.tryParse(txtCtrlMinutes.text) * double.tryParse(txtCtrlMoney.text) ?? 0.0;
      penalty.time = double.tryParse(txtCtrlMinutes.text) ?? 0;
      penalty.money = double.tryParse(txtCtrlMoney.text) ?? 0.0;
    }
  }

  //-----------------------------------------
  void remove() {
    screenEntryVModel.removePenalty(penalty);
  }
}
