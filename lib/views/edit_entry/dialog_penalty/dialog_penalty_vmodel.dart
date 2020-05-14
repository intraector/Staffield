import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_double.dart';
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
      plainSum = TextFieldHandlerDouble(
        label: 'CУММА ШТРАФА',
        maxLength: 8,
        defaultValue: penalty.total?.toString()?.emptyIfZero?.noDotZero?.formatDouble ??
            _type.costDefaultValue?.toString()?.emptyIfZero?.noDotZero,
      );
    } else if (penalty.mode == PenaltyMode.calc) {
      labelTotal = (penalty.total?.toString()?.formatDouble ?? '0.0');
      unit = TextFieldHandlerDouble(
        label: _type.unitTitle.toUpperCase(),
        maxLength: 4,
        defaultValue: penalty.unit?.toString()?.emptyIfZero?.noDotZero?.formatDouble ??
            _type.unitDefaultValue?.toString()?.emptyIfZero?.noDotZero,
        onChange: _calcPenaltyTotal,
      );
      cost = TextFieldHandlerDouble(
        label: 'ЦЕНА',
        maxLength: 4,
        defaultValue: penalty.cost?.toString()?.emptyIfZero?.noDotZero?.formatDouble ??
            _type.costDefaultValue?.toString()?.emptyIfZero?.noDotZero,
        onChange: _calcPenaltyTotal,
      );
    }
  }
  PenaltyType _type;
  String get labelUnit => _type.unitTitle.toUpperCase();
  String get labelTitle => _type.title.toUpperCase();
  String labelTotal;
  String labelTotalPrefix = 'Сумма: '.toUpperCase();
  Penalty penalty;
  final ScreenEditEntryVModel screenEntryVModel;
  TextFieldHandlerDouble plainSum;
  TextFieldHandlerDouble unit;
  TextFieldHandlerDouble cost;

  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();

  //-----------------------------------------
  void _calcPenaltyTotal() {
    penalty.total = unit.result * cost.result;
    labelTotal = penalty.total.toString().formatDouble;
    notifyListeners();
  }

  //-----------------------------------------
  void save() {
    if (penalty.mode == PenaltyMode.plain)
      penalty.total = plainSum.result;
    else if (penalty.mode == PenaltyMode.calc) {
      penalty.unit = unit.result;
      penalty.cost = cost.result;
      penalty.total = penalty.unit * penalty.cost;
    }
  }

  //-----------------------------------------
  void remove() {
    screenEntryVModel.removePenalty(penalty);
  }
}
