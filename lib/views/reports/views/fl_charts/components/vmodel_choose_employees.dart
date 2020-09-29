import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/views/reports/vmodel_reports.dart';
import 'package:get/state_manager.dart';
import 'package:smart_select/smart_select.dart';

class VModelChooseEmployees extends GetxController {
  final EmployeesRepository _employeesRepo = Get.find();
  final VModelReports _vmodelReports = Get.find();

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

  List<Employee> get selectedEmployees => _vmodelReports.selectedEmployees;
  set selectedEmployees(List<Employee> list) {
    _vmodelReports.selectedEmployees = list;
    _vmodelReports.fetchReportData(list);
  }
}
