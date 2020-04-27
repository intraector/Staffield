import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DialogEditEmployeeVModel with ChangeNotifier {
  DialogEditEmployeeVModel(String uid) {
    if (uid != null) {
      employee = repo.getEmployee(uid);
      txtCtrlName.text = employee.name;
    }
  }

  final repo = getIt<EmployeesRepository>();
  Employee employee = Employee();

  final int nameMaxLength = 40;
  final txtCtrlName = TextEditingController();

  //-----------------------------------------
  bool get hideEmployee => employee.hide;

  //-----------------------------------------
  set hideEmployee(bool hide) {
    employee.hide = hide;
    notifyListeners();
  }

  //-----------------------------------------
  String validateName() {
    if (txtCtrlName.text.trim().isEmpty)
      return 'введите имя';
    else {
      return null;
    }
  }

  //-----------------------------------------
  void save() {
    employee.name = txtCtrlName.text.trim();
    repo.addOrUpdate(employee);
  }

  //-----------------------------------------
  void removeEntry() {
    repo.remove(employee.uid);
  }

  //-----------------------------------------
  String labelName = 'Имя';
  String dialogTitle = 'СОТРУДНИК';
  String labelHideEmployee = 'Не показывать в списках';
}
