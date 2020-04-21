import 'package:print_color/print_color.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Staffield/constants/sqlite_tables.dart';
import 'package:Staffield/core/employees_repository_interface.dart';
import 'package:Staffield/core/exceptions/e_insert_employee.dart';
import 'package:Staffield/models/employee.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SrvcSqliteEmployees implements EmployeesRepositoryInterface {
  SrvcSqliteEmployees() {
    Print.yellow('||| fired SrvcSqliteEmployees');
    var init = Injector.get<SrvcSqliteInit>();
    initComplete = init.initComplete;
    initComplete.whenComplete(() {
      db = init.db;
    });
  }

  Future<void> initComplete;
  Database db;

  //-----------------------------------------
  @override
  Future<List<Employee>> fetch() async {
    await initComplete;
    var employeesJsons = await db.query(SqliteTable.employees);
    var result = employeesJsons.map((json) => Employee.fromSqlite(json)).toList();
    return result;
  }

  //-----------------------------------------
  @override
  Future<bool> addOrUpdate(Employee employee) async {
    await initComplete;

    var result = await db.insert(SqliteTable.employees, employee.toSqlite(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (result <= 0)
      throw EInsertEmployee('Can\'t insert SrvcSqliteEmployees');
    else
      return true;
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
