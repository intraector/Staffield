import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:get/state_manager.dart';
import 'package:smart_select/smart_select.dart';

class VModelChooseEmployees extends GetxController {
  final _employeesRepo = Get.find<EmployeesRepository>();

  @override
  void onInit() {
    _selectedUids = employees.map<Employee>((employee) => employee.value).toList();
    super.onInit();
  }

  //-----------------------------------------
  List<S2Choice<Employee>> get employees => _employeesRepo
      .repoWhereHidden(false)
      .map<S2Choice<Employee>>((employee) => S2Choice<Employee>(
            value: employee,
            title: employee.name,
          ))
      .toList();

  //-----------------------------------------
  Employee getEmployeeByUid(String uid) => _employeesRepo.getEmployeeByUid(uid);

  //-----------------------------------------
  var _selectedUids = <Employee>[];
  List<Employee> get selectedUids => _selectedUids;
  set selectedUids(List<Employee> list) {
    _selectedUids = list;
    update();
  }
}
