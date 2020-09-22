import 'dart:async';

import 'package:Staffield/core/employees_repository_interface.dart';
import 'package:Staffield/core/entities/employee.dart';

class EmployeesRepository {
  EmployeesRepository(this.sqlite) {
    fetch();
  }

  EmployeesRepositoryInterface sqlite;

  var _repo = <Employee>[];

  var _streamCtrlRepoUpdates = StreamController<bool>.broadcast();

  //-----------------------------------------
  Stream<bool> get updates => _streamCtrlRepoUpdates.stream;

  //-----------------------------------------
  Employee getEmployee(String uid) => repo.firstWhere((employee) => employee.uid == uid);

  //-----------------------------------------
  List<Employee> get repo => _repo;

  //-----------------------------------------
  List<Employee> repoWhereHidden(bool value) =>
      _repo.where((employee) => employee.hide == value).toList();

  //-----------------------------------------
  void _notifyRepoUpdates() => _streamCtrlRepoUpdates.sink.add(true);

  //-----------------------------------------
  Future<void> fetch() async {
    var result = await sqlite.fetch();
    _repo.addAll(result);
    _notifyRepoUpdates();
  }

  // //-----------------------------------------
  // void add(Employee employee) {
  //   _repo.add(employee);
  // }

  //-----------------------------------------
  void addOrUpdate(Employee employee) {
    var index = _repo.indexOf(employee);
    if (index >= 0)
      _repo[index] = employee;
    else
      _repo.add(employee);
    sqlite.addOrUpdate(employee);
    _notifyRepoUpdates();
  }

  //-----------------------------------------
  void remove(String uid) {
    var index = _repo.indexWhere((employee) => employee.uid == uid);
    if (index >= 0) _repo.removeAt(index);
    sqlite.remove(uid);
    _notifyRepoUpdates();
  }

  //-----------------------------------------
  void update(Employee employee) {
    var index = _repo.indexOf(employee);
    if (index >= 0) _repo[index] = employee;
    _notifyRepoUpdates();
  }

  dispose() {
    _streamCtrlRepoUpdates.close();
  }
}
