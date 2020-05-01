import 'dart:async';

import 'package:Staffield/core/generate_random_entries.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:Staffield/views/reports/adapted_entry_report.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:print_color/print_color.dart';

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

  bool isVisibleDateHeader = false;

  String currentItemDate = '';

  //-----------------------------------------
  void setCurrentItemDate(int index) {
    currentItemDate = cache[index].date;
    isVisibleDateHeader = index == 0 ? false : true;
    notifyListeners();
  }

  //-----------------------------------------
  void updateList() {
    var _currentDate = DateTime.now();
    cache.clear();
    var tmp = <AdaptedEntryReport>[];
    for (var entry in _repo.cache) {
      var _nextDate = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
      if (_nextDate.day != _currentDate.day) {
        _currentDate = _nextDate;
        tmp.add(AdaptedEntryReport.dateLabel(entry));
      }
      tmp.add(AdaptedEntryReport.from(entry.report));
    }
    cache = tmp;
    Print.yellow('||| {cache.length} : ${cache.length}');
    notifyListeners();
  }

  //-----------------------------------------
  Future<int> fetchNextChunk() => _repo.fetchNextChunkToCache();

  //-----------------------------------------
  @override
  void dispose() {
    _subsc.cancel();
    // _streamCtrlItemPosition.close();
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

  // -----------------------------------------
  // var _streamCtrlItemPosition = StreamController<int>.broadcast();
  // Stream<int> get updates => _streamCtrlItemPosition.stream;
  // void _notifyRepoUpdates() => _streamCtrlItemPosition.sink.add(true);
}
