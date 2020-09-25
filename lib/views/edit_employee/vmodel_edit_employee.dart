import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VModelEditEmployee extends GetxController {
  VModelEditEmployee(this.employee);
  double errorIsVisible = 0.0;

  //-----------------------------------------
  @override
  void onInit() {
    employee = repo.getEmployeeByUid(employee?.uid);
    txtCtrlName.text = employee.name;
    super.onInit();
  }

  final repo = Get.find<EmployeesRepository>();
  Employee employee;
  final int nameMaxLength = 40;
  final txtCtrlName = TextEditingController();

  //-----------------------------------------
  bool get hideEmployee => employee.hide;

  //-----------------------------------------
  set hideEmployee(bool hide) {
    employee.hide = hide;
    update();
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
  void changeColor(Color color) {
    if (color != null) {
      employee.color = color;
      update();
    }
  }

  //-----------------------------------------
  void save(BuildContext context) {
    if (txtCtrlName.text.trim().isEmpty) {
      errorIsVisible = 1.0;
      update();
    } else {
      employee.name = txtCtrlName.text.trim();
      repo.addOrUpdate(employee);
      Navigator.of(context).pop(employee);
    }
  }

  //-----------------------------------------
  void removeEntry() {
    repo.remove(employee.uid);
  }

  //-----------------------------------------
  String labelName = 'Имя сотрудника';
  // String dialogTitle = 'СОТРУДНИК';
  String labelHideEmployee = 'Скрыть';
}
