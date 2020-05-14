import 'dart:async';

import 'package:Staffield/core/generate_random_entries.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:Staffield/utils/time_and_difference.dart';
import 'package:Staffield/views/reports/adapted_entry_report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Staffield/core/entries_repository.dart';

final getIt = GetIt.instance;

class ScreenEntriesVModel with ChangeNotifier {
  ScreenEntriesVModel() {
    updateList();
    _subsc = _repo.updates.listen((data) {
      updateList();
    });
  }

  StreamSubscription<bool> _subsc;
  var cache = <AdaptedEntryReport>[];
  final _repo = getIt<EntriesRepository>();
  var _generateRandomEntries = GenerateRandomEntries();

  int get startTimestamp => _repo.startTimestamp;

  bool get endOfData => _repo.endOfData;

  String get startTimestampLabel =>
      'до ' +
      timeAndDifference(
          timestamp1: startTimestamp ?? DateTime.now().millisecondsSinceEpoch,
          showDate: true,
          spellToday: false,
          spellTodayAdditional: true);

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
  void updateList() {
    var _currentDate;
    var result = <AdaptedEntryReport>[];
    if (_repo.cache.isNotEmpty) {
      _currentDate = DateTime.fromMillisecondsSinceEpoch(_repo.cache.first.timestamp);
      result.add(AdaptedEntryReport.dateLabel(_repo.cache.first));
    }
    for (var entry in _repo.cache) {
      var _nextDate = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
      if (_nextDate.day != _currentDate.day) {
        _currentDate = _nextDate;
        result.add(AdaptedEntryReport.dateLabel(entry));
      }
      result.add(AdaptedEntryReport.from(entry.report));
    }
    cache = result;
    notifyListeners();
  }

  //-----------------------------------------
  Future<int> fetchNextChunk() => _repo.fetchNextChunkToCache();

  //-----------------------------------------
  @override
  void dispose() {
    _subsc.cancel();
    super.dispose();
  }

  //-----------------------------------------
  void generateRandomEntries({int days, int recordsPerDay}) =>
      _generateRandomEntries.generateRandomEntries(days: days, recordsPerDay: recordsPerDay);

  //-----------------------------------------
  Future<void> refreshDb() async {
    var sqliteInit = getIt<SrvcSqliteInit>();
    await sqliteInit.deleteDb();
    await sqliteInit.init();
  }
}
