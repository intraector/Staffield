import 'package:Staffield/services/sqlite/sqlite_convert.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Staffield/services/sqlite/sqlite_tables.dart';
import 'package:Staffield/core/employees_repository_interface.dart';
import 'package:Staffield/core/exceptions/e_insert_employee.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';

class SrvcSqliteEmployees implements EmployeesRepositoryInterface {
  SrvcSqliteEmployees() {
    final init = Get.find<SrvcSqliteInit>();

    initComplete = init.initComplete;
    initComplete.whenComplete(() {
      db = init.db;
    });
  }

  Database db;
  Future<void> initComplete;

  //-----------------------------------------
  @override
  Future<bool> addOrUpdate(Employee employee) async {
    await initComplete;

    var result = await db.insert(SqliteTable.employees, SqliteConvert.employeeToMap(employee),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (result <= 0)
      throw EInsertEmployee('Can\'t insert SrvcSqliteEmployees');
    else
      return true;
  }

  //-----------------------------------------
  @override
  Future<List<Employee>> fetch() async {
    await initComplete;
    var employeesJsons = await db.query(SqliteTable.employees);
    var result = employeesJsons.map((json) => SqliteConvert.mapToEmployee(json)).toList();
    return result;
  }

  //-----------------------------------------
  @override
  Future<Employee> getEmployee(String uid) async {
    await initComplete;
    var result = await db.query(SqliteTable.employees, where: 'uid = ?', whereArgs: [uid]);
    return SqliteConvert.mapToEmployee(result.first);
  }

  //-----------------------------------------
  @override
  Future<int> remove(String uid) async {
    await initComplete;
    return db.delete(
      SqliteTable.employees,
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }
}
