import 'package:Staffield/core/entities/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/views/common/dialog_confirm.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_data_decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:Staffield/core/entities/penalty_mode.dart';
import 'package:Staffield/core/entities/penalty.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/edit_entry/vmodel_edit_entry.dart';
import 'package:get/get.dart';

class DialogPenaltyVModel extends ChangeNotifier {
  DialogPenaltyVModel({@required this.penalty, @required this.screenEntryVModel}) {
    _type = _penaltyTypesRepo.getType(penalty.typeUid);
    penalty.mode = _type.mode;
    if (penalty.mode == PenaltyMode.plain) {
      plainSum = TextFieldDataDecimal(
        label: 'CУММА ШТРАФА',
        maxLength: 8,
        defaultValue: penalty.total?.toString()?.emptyIfZero?.formatAsCurrency() ??
            _type.costDefaultValue?.toString()?.emptyIfZero?.noDotZero,
      );
    } else if (penalty.mode == PenaltyMode.calc) {
      labelTotal = (penalty.total?.toString()?.formatAsCurrency() ?? '0.0');
      unit = TextFieldDataDecimal(
        label: _type.unitTitle.toUpperCase(),
        maxLength: 4,
        defaultValue: penalty.units?.toString()?.emptyIfZero?.formatAsCurrency() ??
            _type.unitDefaultValue?.toString()?.emptyIfZero?.noDotZero,
        onChanged: _calcPenaltyTotal,
      );
      cost = TextFieldDataDecimal(
        label: 'ЦЕНА',
        maxLength: 4,
        defaultValue: penalty.cost?.toString()?.emptyIfZero?.formatAsCurrency() ??
            _type.costDefaultValue?.toString()?.emptyIfZero?.noDotZero,
        onChanged: _calcPenaltyTotal,
      );
    }
  }
  PenaltyType _type;
  String get labelUnit => _type.unitTitle.toUpperCase();
  String get labelTitle => _type.title.toUpperCase();
  String labelTotal;
  String labelTotalPrefix = 'Сумма: '.toUpperCase();
  Penalty penalty;
  final VModelEditEntry screenEntryVModel;
  TextFieldDataDecimal plainSum;
  TextFieldDataDecimal unit;
  TextFieldDataDecimal cost;

  final _penaltyTypesRepo = Get.find<PenaltyTypesRepository>();

  //-----------------------------------------
  void _calcPenaltyTotal() {
    penalty.total = unit.value * cost.value;
    labelTotal = penalty.total.toString().formatAsCurrency(decimals: 2);
    notifyListeners();
  }

  //-----------------------------------------
  void save() {
    if (penalty.mode == PenaltyMode.plain)
      penalty.total = plainSum.value;
    else if (penalty.mode == PenaltyMode.calc) {
      penalty.units = unit.value;
      penalty.cost = cost.value;
      penalty.total = penalty.units * penalty.cost;
    }
  }

  //-----------------------------------------
  Future<void> remove({@required BuildContext context}) async {
    var isConfirmed = await dialogConfirm(context, text: ('Удалить этот штраф?'));
    if (isConfirmed ?? false) {
      screenEntryVModel.removePenalty(penalty);
      Navigator.of(context).pop();
    }
  }
}
