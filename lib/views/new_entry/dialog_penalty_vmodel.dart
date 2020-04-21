import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:Staffield/constants/penalty_type.dart';
import 'package:Staffield/models/penalty.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/new_entry/screen_entry_vmodel.dart';

class DialogPenaltyVModel extends StatesRebuilder {
  DialogPenaltyVModel(this.penalty) {
    if (penalty.type == PenaltyType.plain) {
      txtCtrlPlainSum.text = penalty.total?.toString()?.formatCurrencyDecimal() ?? '';
    } else if (penalty.type == PenaltyType.minutesByMoney) {
      labelTotal = labelTotalPrefix + (penalty.total?.toString()?.formatCurrency() ?? '0.0');
      txtCtrlMinutes.text = penalty.minutes?.toString() ?? '';
      txtCtrlMoney.text = penalty.money?.toString() ?? '';
    }
  }
  Penalty penalty;

  var screenEntryVModel = Injector.getAsReactive<ScreenEntryVModel>();

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
  String titleOf(PenaltyType type) => getPenaltyTitle(type);

  //-----------------------------------------
  void calcPenaltyTimeByMoney() {
    if (txtCtrlMinutes.text.isNotEmpty && txtCtrlMoney.text.isNotEmpty)
      penalty.total =
          (int.tryParse(txtCtrlMinutes.text) * int.tryParse(txtCtrlMoney.text)).toDouble() ?? 0.0;
    else
      penalty.total = 0.0;

    labelTotal = labelTotalPrefix + penalty.total.toString().formatCurrency();
    rebuildStates();
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
    if (txtCtrlMinutes.text.isEmpty)
      return 'введите минуты';
    else
      return null;
  }

  //-----------------------------------------
  String validateMoney() {
    if (txtCtrlMoney.text.isEmpty)
      return 'введите сумму';
    else
      return null;
  }

  //-----------------------------------------
  void save() {
    if (penalty.type == PenaltyType.plain)
      penalty.total = double.tryParse(txtCtrlPlainSum.text) ?? 0;
    else if (penalty.type == PenaltyType.minutesByMoney) {
      penalty.total =
          (int.tryParse(txtCtrlMinutes.text) * int.tryParse(txtCtrlMoney.text)).toDouble() ?? 0;
      penalty.minutes = int.tryParse(txtCtrlMinutes.text) ?? 0;
      penalty.money = int.tryParse(txtCtrlMoney.text) ?? 0;
    }
  }

  //-----------------------------------------
  void remove() {
    screenEntryVModel.setState((state) => state.removePenalty(penalty));
  }
}
