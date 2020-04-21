import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/models/employee.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ScreenEmployeesVModel with StatesRebuilder {
  ScreenEmployeesVModel() {
    _repo.updates.listen((data) {
      updateList();
    });
  }
  var list = <Employee>[];
  int recordsPerScreen = 10;
  final _repo = Injector.get<EmployeesRepository>();

  //-----------------------------------------
  void updateList() {
    list = _repo.repo.take(recordsPerScreen).toList();
    rebuildStates();
  }
}
