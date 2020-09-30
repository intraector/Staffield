import 'dart:ui';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entities/entry.dart';
import 'package:Staffield/core/entities/penalty.dart';
import 'package:Staffield/core/entities/penalty_type.dart';
import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:get/get.dart';

class SqliteConvert {
  //-----------------------------------------
  static Map<String, dynamic> entryToMap(Entry entry) => {
        SqliteFieldsEntries.uid: entry.uid,
        SqliteFieldsEntries.timestamp: entry.timestamp ?? DateTime.now().millisecondsSinceEpoch,
        SqliteFieldsEntries.employeeUid: entry.employee.uid,
        SqliteFieldsEntries.total: entry.total,
        SqliteFieldsEntries.revenue: entry.revenue,
        SqliteFieldsEntries.wage: entry.wage,
        SqliteFieldsEntries.interest: entry.interest,
      };

  //-----------------------------------------
  static Entry mapToEntry(Map<String, dynamic> map) {
    var employees = Get.find<EmployeesRepository>();
    var entry = Entry();
    entry.uid = map[SqliteFieldsEntries.uid];
    entry.timestamp = map[SqliteFieldsEntries.timestamp];
    entry.employee = employees.getEmployeeByUid(map[SqliteFieldsEntries.employeeUid]);
    entry.total = map[SqliteFieldsEntries.total];
    entry.revenue = map[SqliteFieldsEntries.revenue];
    entry.wage = map[SqliteFieldsEntries.wage];
    entry.interest = map[SqliteFieldsEntries.interest];
    return entry;
  }

  //-----------------------------------------
  static Penalty mapToPenalty(Map<String, dynamic> map) {
    var penalty = Penalty(
      parentUid: map[SqliteFieldsPenalties.parentUid],
      typeUid: map[SqliteFieldsPenalties.typeId],
      mode: map[SqliteFieldsPenalties.mode],
    );
    penalty.uid = map[SqliteFieldsPenalties.uid];
    penalty.timestamp = map[SqliteFieldsPenalties.timestamp];
    penalty.total = map[SqliteFieldsPenalties.total];
    penalty.units = map[SqliteFieldsPenalties.unit];
    penalty.cost = map[SqliteFieldsPenalties.cost];
    return penalty;
  }

  //-----------------------------------------
  static Map<String, dynamic> penaltyToMap(Penalty penalty) => {
        SqliteFieldsPenalties.uid: penalty.uid,
        SqliteFieldsPenalties.parentUid: penalty.parentUid,
        SqliteFieldsPenalties.mode: penalty.mode,
        SqliteFieldsPenalties.typeId: penalty.typeUid,
        SqliteFieldsPenalties.timestamp: penalty.timestamp ?? DateTime.now().millisecondsSinceEpoch,
        SqliteFieldsPenalties.total: penalty.total,
        SqliteFieldsPenalties.unit: penalty.units,
        SqliteFieldsPenalties.cost: penalty.cost,
      };
  //-----------------------------------------
  static Employee mapToEmployee(Map<String, dynamic> map) => Employee(
        uid: map[SqliteFieldsEmployees.uid],
        name: map[SqliteFieldsEmployees.name],
        hide: map[SqliteFieldsEmployees.hide] == 1 ? true : false,
        color: Color(map[SqliteFieldsEmployees.color]),
      );

  //-----------------------------------------
  static Map<String, dynamic> employeeToMap(Employee employee) {
    return {
      SqliteFieldsEmployees.uid: employee.uid,
      SqliteFieldsEmployees.name: employee.name,
      SqliteFieldsEmployees.hide: employee.hide ? 1 : 0,
      SqliteFieldsEmployees.color: employee.color.value,
    };
  }

  //-----------------------------------------
  static Map<String, dynamic> penaltyTypeToMap(PenaltyType penaltyType) => {
        SqliteFieldsPenaltyTypes.uid: penaltyType.uid,
        SqliteFieldsPenaltyTypes.mode: penaltyType.mode,
        SqliteFieldsPenaltyTypes.title: penaltyType.title,
        SqliteFieldsPenaltyTypes.unitTitle: penaltyType.unitTitle,
        SqliteFieldsPenaltyTypes.unitDefaultValue: penaltyType.unitDefaultValue,
        SqliteFieldsPenaltyTypes.costDefaultValue: penaltyType.costDefaultValue,
        SqliteFieldsPenaltyTypes.hide: penaltyType.hide ? 1 : 0,
      };

  //-----------------------------------------
  static PenaltyType mapToPenaltyType(Map<String, dynamic> map) {
    var output = PenaltyType();
    output.uid = map[SqliteFieldsPenaltyTypes.uid];
    output.mode = map[SqliteFieldsPenaltyTypes.mode];
    output.title = map[SqliteFieldsPenaltyTypes.title];
    output.unitTitle = map[SqliteFieldsPenaltyTypes.unitTitle];
    output.unitDefaultValue = map[SqliteFieldsPenaltyTypes.unitDefaultValue];
    output.costDefaultValue = map[SqliteFieldsPenaltyTypes.costDefaultValue];
    output.hide = map[SqliteFieldsPenaltyTypes.hide] == 0 ? false : true;
    return output;
  }
}
