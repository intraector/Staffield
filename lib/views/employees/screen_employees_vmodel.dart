import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/models/employee.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ScreenEmployeesVModel with ChangeNotifier {
  ScreenEmployeesVModel() {
    _repo.updates.listen((data) {
      updateList();
    });
  }
  var list = <Employee>[];
  int recordsPerScreen = 10;
  final _repo = getIt<EmployeesRepository>();

  //-----------------------------------------
  void updateList() {
    list = _repo.repo.take(recordsPerScreen).toList();
    notifyListeners();
  }
}
