import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:print_color/print_color.dart';

final getIt = GetIt.instance;

class DialogPenaltyTypeVModel extends ChangeNotifier {
  DialogPenaltyTypeVModel(PenaltyType type) {
    if (type.mode == null)
      this.type = _penaltyTypesRepo.repo.first;
    else
      this.type = type.clone;
  }

  int maxLength = 9;
  final txtCtrlCost = TextEditingController();
  final txtCtrlUnit = TextEditingController();
  PenaltyType type;

  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();

  //-----------------------------------------
  // String validatePlainSum() {
  //   if (txtCtrlPlainSum.text.isEmpty)
  //     return 'введите сумму';
  //   else {
  //     int result = int.tryParse(txtCtrlPlainSum.text) ?? 0;
  //     if (result > 0)
  //       return null;
  //     else
  //       return 'введите сумму';
  //   }
  // }

  //-----------------------------------------
  String validateMinutes() {
    int result = int.tryParse(txtCtrlUnit.text) ?? 0;
    return result == 0 ? 'введите минуты' : null;
  }

  //-----------------------------------------
  String validateMoney() => txtCtrlCost.text.isEmpty ? 'введите сумму' : null;

  //-----------------------------------------
  // void save() {
  //   if (penaltyType.mode == PenaltyMode.plain)
  //     penaltyType.total = double.tryParse(txtCtrlPlainSum.text) ?? 0;
  //   else if (penaltyType.mode == PenaltyMode.calc) {
  //     penaltyType.total =
  //         double.tryParse(txtCtrlUnit.text) * double.tryParse(txtCtrlCost.text) ?? 0.0;
  //     penaltyType.unit = double.tryParse(txtCtrlUnit.text) ?? 0;
  //     penaltyType.cost = double.tryParse(txtCtrlCost.text) ?? 0.0;
  //   }
  // }

  //-----------------------------------------
  void remove() {
    // screenEntryVModel.removePenalty(penalty);
  }

  //-----------------------------------------
  List<DropdownMenuItem> get dropdownItems {
    return [
      DropdownMenuItem<String>(child: Text('Простой'), value: PenaltyMode.plain),
      DropdownMenuItem<String>(child: Text('Вычисляемый'), value: PenaltyMode.calc),
    ];
  }
}
