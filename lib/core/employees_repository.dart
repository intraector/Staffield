import 'dart:async';

import 'package:Staffield/core/employees_repository_interface.dart';
import 'package:Staffield/models/employee.dart';

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
  List<Employee> get repo => _repo;

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
  void remove(Employee employee) {
    var index = _repo.indexOf(employee);
    if (index >= 0) _repo.removeAt(index);
    sqlite.remove(employee.uid);
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
