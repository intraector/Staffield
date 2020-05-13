import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ScreenEditPenaltyTypeVModel extends ChangeNotifier {
  ScreenEditPenaltyTypeVModel(PenaltyType type) {
    if (type.mode == null)
      this.type = _penaltyTypesRepo.repo.first.copy;
    else
      this.type = type.copy;
  }

  PenaltyType type;

  String get mode => type.mode;
  set mode(String mode) {
    type.mode = mode;
    notifyListeners();
  }

  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();

  //-----------------------------------------
  void save(GlobalKey<FormState> formKey) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      _penaltyTypesRepo.addOrUpdate(type);
    }
  }

  //-----------------------------------------
  void remove() {
    // screenEntryVModel.removePenalty(penalty);
  }

  //-----------------------------------------
  List<DropdownMenuItem<String>> get dropdownItems {
    return [
      DropdownMenuItem<String>(child: Text('Простой'), value: PenaltyMode.plain),
      DropdownMenuItem<String>(child: Text('Вычисляемый'), value: PenaltyMode.calc),
    ];
  }
}
