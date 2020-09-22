import 'dart:async';

import 'package:Staffield/core/generate_random_entries.dart';
import 'package:Staffield/core/entities/entity_convert.dart';
import 'package:Staffield/core/entities/report.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:Staffield/views/reports/report_ui_adapted.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class VModelViewEntries extends GetxController {
  @override
  void onInit() {
    _updateList();
    _subsc = _repo.updates.listen((event) {
      _updateList();
    });
    super.onInit();
  }

  StreamSubscription<bool> _subsc;
  var cache = <ReportUiAdapted>[];
  final _repo = EntriesRepository.find;
  var _generateRandomEntries = GenerateRandomEntries();

  int get startTimestamp => _repo.startTimestamp;

  bool get endOfData => _repo.endOfData;

  String get startTimestampLabel =>
      'до ' +
      Jiffy(startTimestamp != null
              ? DateTime.fromMillisecondsSinceEpoch(startTimestamp)
              : DateTime.now())
          .MMMMd;
  // timeAndDifference(
  //     timestamp1: startTimestamp ?? DateTime.now().millisecondsSinceEpoch,
  //     showDate: true,
  //     spellToday: false,
  //     spellTodayAdditional: true);

  //-----------------------------------------
  void setEndTimestamp({@required BuildContext context}) async {
    var now = DateTime.now();
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
      initialDate:
          DateTime.fromMillisecondsSinceEpoch(startTimestamp ?? now.millisecondsSinceEpoch),
    );
    if (date != null) {
      date = DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch - 1)
          .add(Duration(days: 1));
      _repo.startTimestamp = date.millisecondsSinceEpoch;
    }
  }

  //-----------------------------------------
  void _updateList() {
    var _currentDate;
    var result = <Report>[];
    if (_repo.cache.isNotEmpty) {
      _currentDate = DateTime.fromMillisecondsSinceEpoch(_repo.cache.first.timestamp);
      result.add(Report.dateLabel(_repo.cache.first.timestamp));
    }
    for (var entry in _repo.cache) {
      var _nextDate = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
      if (_nextDate.day != _currentDate.day) {
        _currentDate = _nextDate;
        result.add(Report.dateLabel(entry.timestamp));
      }
      result.add(EntityConvert.entryToReport(entry));
    }
    cache.clear();
    for (var report in result) {
      cache.add(ReportUiAdapted.from(report));
    }
    update();
  }

  //-----------------------------------------
  Future<int> fetchNextChunk() => _repo.fetchNextChunkToCache();

  //-----------------------------------------
  void generateRandomEntries({int days, int recordsPerDay}) =>
      _generateRandomEntries.generateRandomEntries(days: days, recordsPerDay: recordsPerDay);

  //-----------------------------------------
  Future<void> refreshDb() async {
    var sqliteInit = Get.find<SrvcSqliteInit>();
    await sqliteInit.deleteDb();
    await sqliteInit.init();
  }

  @override
  FutureOr onClose() {
    _subsc.cancel();
    return super.onClose();
  }
}
