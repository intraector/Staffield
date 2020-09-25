import 'dart:async';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:get/get.dart';

class VModelEmployees extends GetxController {
  VModelEmployees() {
    updateList();
    _subsc = _repo.updates.listen((data) {
      updateList();
    });
  }

  StreamSubscription _subsc;
  var list = <Employee>[];
  int recordsPerScreen = 10;
  final _repo = Get.find<EmployeesRepository>();
  bool isShowingHiddenEmployees = false;

  //-----------------------------------------
  bool get mode => isShowingHiddenEmployees;
  void switchMode() {
    isShowingHiddenEmployees = !isShowingHiddenEmployees;
    updateList();
  }

  //-----------------------------------------
  void updateList() {
    list = _repo.repoWhereHidden(isShowingHiddenEmployees);
    update();
  }

  String get modeButtonLabel => isShowingHiddenEmployees ? 'АРХИВ' : 'АКТИВНЫЕ';

  //-----------------------------------------
  @override
  FutureOr onClose() {
    _subsc.cancel();
    return super.onClose();
  }
}
