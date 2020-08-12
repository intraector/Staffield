import 'dart:async';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:flutter/foundation.dart';

class EntriesRepository {
  EntriesRepository(this.sqlite) {
    fetchNextChunkToCache();
  }

  final EntriesRepositoryInterface sqlite;

  var _cache = <Entry>[];

  bool _isLoading = false;
  bool endOfData = false;

  int _startTimestamp;
  int _oldestTimestamp;
  int limit = 100;

  //-----------------------------------------
  int get startTimestamp => _startTimestamp;

  set startTimestamp(int timestamp) {
    _startTimestamp = timestamp;
    fetchNextChunkToCache(restart: true);
  }

  //-----------------------------------------
  var _streamCtrlCacheUpdates = StreamController<bool>.broadcast();
  Stream<bool> get updates => _streamCtrlCacheUpdates.stream;
  void _notifyRepoUpdates() => _streamCtrlCacheUpdates.sink.add(true);

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
      employeeUid: null,
      limit: limit,
    );
    if (result.length == 0) endOfData = true;
    setOldestTimestampFrom(result);
    restart == false ? _cache.addAll(result) : _cache = result;
    _notifyRepoUpdates();
    _isLoading = false;
    return result.length;
  }

  //-----------------------------------------
  Future<List<Entry>> fetch({
    @required int greaterThan,
    @required int lessThan,
    @required String employeeUid,
    int limit,
  }) async {
    var result = await sqlite.fetch(
      greaterThan: greaterThan,
      lessThan: lessThan,
      employeeUid: employeeUid,
      limit: limit,
    );
    // Print.yellow('||| result : $result');
    return result;
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(List<Entry> entries) {
    for (var entry in entries) {
      var index = _cache.indexOf(entry);
      if (index >= 0)
        _cache[index] = entry;
      else
        _cache.insert(0, entry);
    }
    _notifyRepoUpdates();
    return sqlite.addOrUpdate(entries);
  }

  //-----------------------------------------
  void remove(String uid) {
    var index = _cache.indexWhere((entry) => entry.uid == uid);
    if (index >= 0) _cache.removeAt(index);
    sqlite.remove(uid);
    _notifyRepoUpdates();
  }

  //-----------------------------------------
  void setOldestTimestampFrom(List<Entry> list) {
    if (list.isEmpty) return null;
    var _oldest = list
        .reduce((current, next) => current.timestamp < next.timestamp ? current : next)
        .timestamp;
    if (_oldest != null) _oldestTimestamp = _oldest;
  }

  //-----------------------------------------
  dispose() {
    _streamCtrlCacheUpdates.close();
  }
}
