import 'dart:async';
import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/core/entities/entry.dart';
import 'package:Staffield/services/sqlite/entries_sqlite_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class EntriesRepository extends GetxController {
  final EntriesRepositoryInterface sqlite = Get.find<EntriesSqliteAdapater>();
  static EntriesRepository get find => Get.find();
  var _cache = <Entry>[];

  bool _isLoading = false;
  bool endOfData = false;

  int _startTimestamp;
  int _oldestTimestamp;
  int limit = 100;

  StreamController _updates = StreamController<bool>.broadcast();
  void notify() => _updates.sink.add(true);
  Stream<bool> get updates => _updates.stream;

  //-----------------------------------------
  int get startTimestamp => _startTimestamp;

  set startTimestamp(int timestamp) {
    _startTimestamp = timestamp;
    fetchNextChunkToCache(restart: true);
    notify();
  }

  //-----------------------------------------
  List<Entry> get cache => _cache;

  //-----------------------------------------
  int get newestTimestamp => _cache.first.timestamp;

  //-----------------------------------------
  Entry getEntry(String uid) => _cache.firstWhere((entry) => entry.uid == uid);

  //-----------------------------------------
  Future<int> fetchNextChunkToCache({bool restart = false}) async {
    if (_isLoading) return 0;
    if (restart) endOfData = false;
    if (endOfData) return 0;
    _isLoading = true;
    var result = await fetch(
      greaterThan: null,
      lessThan: restart ? _startTimestamp : _oldestTimestamp,
      employees: null,
      limit: limit,
    );
    if (result.length == 0) endOfData = true;
    setOldestTimestampFrom(result);
    restart == false ? _cache.addAll(result) : _cache = result;
    notify();
    _isLoading = false;
    return result.length;
  }

  //-----------------------------------------
  Future<List<Entry>> fetch({
    @required int greaterThan,
    @required int lessThan,
    @required List<Employee> employees,
    int limit,
  }) async =>
      sqlite.fetch(
        greaterThan: greaterThan,
        lessThan: lessThan,
        employees: employees,
        limit: limit,
      );

  //-----------------------------------------
  Future<bool> addOrUpdate(List<Entry> entries) {
    for (var entry in entries) {
      var index = _cache.indexOf(entry);
      if (index >= 0)
        _cache[index] = entry;
      else
        _cache.insert(0, entry);
    }
    notify();
    return sqlite.addOrUpdate(entries);
  }

  //-----------------------------------------
  void remove(String uid) {
    var index = _cache.indexWhere((entry) => entry.uid == uid);
    if (index >= 0) _cache.removeAt(index);
    notify();
    sqlite.remove(uid);
  }

  //-----------------------------------------
  void setOldestTimestampFrom(List<Entry> list) {
    if (list.isEmpty) return null;
    var _oldest = list
        .reduce((current, next) => current.timestamp < next.timestamp ? current : next)
        .timestamp;
    if (_oldest != null) _oldestTimestamp = _oldest;
  }

  @override
  FutureOr onClose() {
    _updates.close();
    return super.onClose();
  }
}
