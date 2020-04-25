import 'dart:async';
import 'dart:math';

import 'package:Staffield/constants/penalty_type.dart';
import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/models/entry.dart';
import 'package:Staffield/models/penalty.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:print_color/print_color.dart';

class EntriesRepository {
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
    var _dates = generateRandomDatesOverPeriod(days: days, recordsPerDay: recordsPerDay);
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
      entry.penalties = generateRandomPenalties(parentUid: entry.uid, maxCount: 3);
      var fold = entry.penalties.fold<double>(0, (value, penalty) => value + penalty.total);
      var _bonus = entry.revenue * entry.interest / 100;
      entry.total = (entry.wage + _bonus - fold).roundToDouble();
      addOrUpdate(entry);
    }
  }

  //-----------------------------------------
  List<DateTime> generateRandomDatesOverPeriod({int days, int recordsPerDay}) {
    var timestampNow = DateTime.now();
    var list = <DateTime>[];
    for (var i = 1; i <= days; i++) {
      var timestampMin = timestampNow.subtract(Duration(days: i));
      var timestampMax = timestampMin.add(Duration(days: 1));
      list.addAll(generateRandomDatesBetweenPointsInTime(
          min: timestampMin, max: timestampMax, count: recordsPerDay));
    }
    return list;
  }

  //-----------------------------------------
  List<DateTime> generateRandomDatesBetweenPointsInTime({DateTime min, DateTime max, int count}) {
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
  List<Penalty> generateRandomPenalties({@required String parentUid, @required int maxCount}) {
    if (maxCount == null) return [];
    var result = <Penalty>[];
    var random = Random();
    var count = random.nextInt(maxCount + 1);
    for (int i = 0; i < count; i++) {
      var penalty = Penalty(parentUid: parentUid, type: PenaltyType.values[random.nextInt(2)]);
      penalty.minutes = 1 + random.nextInt(20);
      penalty.money = 10;
      if (penalty.type == PenaltyType.plain)
        penalty.total = 10 * random.nextInt(21).toDouble();
      else
        penalty.total = penalty.minutes.toDouble() * penalty.money.toDouble();
      result.add(penalty);
    }
    return result;
  }

  //-----------------------------------------
  dispose() {
    _streamCtrlRepoUpdates.close();
  }
}
