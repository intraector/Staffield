import 'dart:async';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ScreenEmployeesVModel with ChangeNotifier {
  ScreenEmployeesVModel() {
    updateList();
    _subsc = _repo.updates.listen((data) {
      updateList();
    });
  }

  StreamSubscription _subsc;
  var list = <Employee>[];
  int recordsPerScreen = 10;
  final _repo = getIt<EmployeesRepository>();

  //-----------------------------------------
  void updateList() {
    list = _repo.repo.take(recordsPerScreen).toList();
    notifyListeners();
  }

  //-----------------------------------------
  @override
  void dispose() {
    _subsc.cancel();
    super.dispose();
  }
}
