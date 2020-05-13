import 'dart:async';

import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class PenaltyTypesVModel extends ChangeNotifier {
  PenaltyTypesVModel() {
    updateList();
    _subsc = _penaltyTypesRepo.updates.listen((data) {
      updateList();
    });
  }
  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();
  List<PenaltyType> cache;
  StreamSubscription<bool> _subsc;

  //-----------------------------------------
  void updateList() {
    cache = _penaltyTypesRepo.repo;
    notifyListeners();
  }

  //-----------------------------------------
  @override
  void dispose() {
    _subsc.cancel();
    super.dispose();
  }
}
