import 'dart:math';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:print_color/print_color.dart';

var getIt = GetIt.instance;

class GenerateRandomEntries {
  //-----------------------------------------
  var _employeesRepo = getIt<EmployeesRepository>();
  var _entriesRepo = getIt<EntriesRepository>();
  var _penaltyTypesRepo = getIt<PenaltyTypesRepository>();

  void generateRandomEntries({int days, int recordsPerDay}) {
    var _employees = _employeesRepo.repo;
    if (_employees.length == 0) {
      Print.red('Employees list is empty');
      return;
    }
    var _dates = generateRandomDatesOverPeriod(days: days, recordsPerDay: recordsPerDay);
    var random = Random();
    var list = <Entry>[];
    for (var date in _dates) {
      var entry = Entry();
      entry.timestamp = date.millisecondsSinceEpoch;
      var _tmp = random.nextInt(_employees.length);
      entry.employeeUid = _employees[_tmp].uid;
      entry.employeeName = _employeesRepo.getEmployee(entry.employeeUid).name;
      entry.revenue = random.nextDouble() * 20000;
      entry.wage = (200 + random.nextInt(400)).toDouble();
      entry.interest = (1 + random.nextInt(4)).toDouble();
      entry.penalties =
          generateRandomPenalties(parentUid: entry.uid, maxCount: 3, timestamp: entry.timestamp);
      var fold = entry.penalties.fold<double>(0, (value, penalty) => value + penalty.total);
      var _bonus = entry.revenue * entry.interest / 100;
      entry.total = (entry.wage + _bonus - fold).roundToDouble();
      list.add(entry);
    }
    _entriesRepo.addOrUpdate(list);
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
  List<Penalty> generateRandomPenalties(
      {@required String parentUid, @required timestamp, @required int maxCount}) {
    if (maxCount == null) return [];
    var result = <Penalty>[];
    var random = Random();
    var count = random.nextInt(maxCount + 1);
    for (int i = 0; i < count; i++) {
      var randomType = _penaltyTypesRepo.getRandom();
      var penalty = Penalty(parentUid: parentUid, typeUid: randomType.uid, mode: randomType.mode);
      penalty.timestamp = timestamp;
      if (penalty.mode == PenaltyMode.plain)
        penalty.total = 10 * random.nextInt(21).toDouble();
      else {
        penalty.units = 1 + random.nextInt(20).toDouble();
        penalty.cost = 10;
        penalty.total = penalty.units.toDouble() * penalty.cost.toDouble();
      }
      result.add(penalty);
    }
    return result;
  }
}
