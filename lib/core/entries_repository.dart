import 'dart:async';
import 'dart:math';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/models/entry.dart';
import 'package:get_it/get_it.dart';
import 'package:print_color/print_color.dart';

class EntriesRepository {
  // EntriesRepository._privateConstructor();
  // static final EntriesRepository _instance = EntriesRepository._privateConstructor();
  // factory EntriesRepository() => _instance;

  EntriesRepository(this.sqlite) {
    fetch();
  }

  EntriesRepositoryInterface sqlite;

  var _repo = <Entry>[];

  var _streamCtrlRepoUpdates = StreamController<bool>.broadcast();
  //-----------------------------------------
  Stream<bool> get updates => _streamCtrlRepoUpdates.stream;
  //-----------------------------------------
  List<Entry> get repo => _repo;

  //-----------------------------------------
  Entry getEntry(String uid) => _repo.firstWhere((entry) => entry.uid == uid);

  //-----------------------------------------
  void _notifyRepoUpdates() => _streamCtrlRepoUpdates.sink.add(true);

  //-----------------------------------------
  Future<void> fetch() async {
    var res = await sqlite.fetch();
    _repo.addAll(res);
    _notifyRepoUpdates();
  }

  //-----------------------------------------
  void addOrUpdate(Entry entry) {
    var index = _repo.indexOf(entry);
    if (index >= 0)
      _repo[index] = entry;
    else
      _repo.add(entry);
    sqlite.addOrUpdate(entry);
    _notifyRepoUpdates();
  }

  //-----------------------------------------
  void remove(String uid) {
    var index = _repo.indexWhere((entry) => entry.uid == uid);
    if (index >= 0) _repo.removeAt(index);
    sqlite.remove(uid);
    _notifyRepoUpdates();
  }

  //-----------------------------------------
  static var getIt = GetIt.instance;
  var _employeesRepo = getIt<EmployeesRepository>();

  void generateRandomEntries({int days, int recordsPerDay}) {
    var _employees = _employeesRepo.repo;
    if (_employees.length == 0) {
      Print.red('||| Employees list is empty');
      return;
    }
    var _dates = generateRandomDates(days: days, recordsPerDay: recordsPerDay);
    var random = Random();

    for (var date in _dates) {
      var entry = Entry();
      entry.timestamp = date.millisecondsSinceEpoch;
      var _tmp = random.nextInt(_employees.length);
      entry.employeeUid = _employees[_tmp].uid;
      entry.employeeName = _employeesRepo.getEmployee(entry.employeeUid).name;
      entry.revenue = random.nextDouble() * 20000;
      entry.wage = (200 + random.nextInt(400)).toDouble();
      entry.interest = (1 + random.nextInt(4)).toDouble();
      addOrUpdate(entry);
    }
  }

  //-----------------------------------------
  List<DateTime> generateRandomDates({int days, int recordsPerDay}) {
    var timestampNow = DateTime.now();
    var list = <DateTime>[];
    for (var i = 1; i <= days; i++) {
      var timestampMin = timestampNow.subtract(Duration(days: i));
      var timestampMax = timestampMin.add(Duration(days: 1));
      list.addAll(generateRandom(min: timestampMin, max: timestampMax, count: recordsPerDay));
    }
    // Print.yellow('||| count : ${list.length}');
    // for (var date in list) Print.yellow('||| date : $date');
    return list;
  }

  List<DateTime> generateRandom({DateTime min, DateTime max, int count}) {
    var minInt = min.millisecondsSinceEpoch;
    var maxnInt = max.millisecondsSinceEpoch;
    var random = Random();
    var difference = maxnInt - minInt;
    var list = <DateTime>[];
    for (var i = 1; i <= count; i++) {
      var result = maxnInt + random.nextInt(difference);
      list.add(DateTime.fromMillisecondsSinceEpoch(result));
    }
    return list;
  }

  //-----------------------------------------
  dispose() {
    _streamCtrlRepoUpdates.close();
  }
}
