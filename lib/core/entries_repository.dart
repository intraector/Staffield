import 'dart:async';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:flutter/foundation.dart';

class EntriesRepository {
  EntriesRepository(this.sqlite) {
    fetchNextChunkToCache();
  }

  EntriesRepositoryInterface sqlite;

  var _cache = <Entry>[];

  var _streamCtrlCacheUpdates = StreamController<bool>.broadcast();

  int limit = 100;

  int oldestTimestamp;

  bool _isLoading = false;
  bool _endOfData = false;

  //-----------------------------------------
  Stream<bool> get updates => _streamCtrlCacheUpdates.stream;
  void _notifyRepoUpdates() => _streamCtrlCacheUpdates.sink.add(true);

  //-----------------------------------------
  List<Entry> get cache => _cache;

  //-----------------------------------------
  Entry getEntry(String uid) => _cache.firstWhere((entry) => entry.uid == uid);

  //-----------------------------------------
  Future<int> fetchNextChunkToCache() async {
    if (_isLoading) return 0;
    if (_endOfData) return 0;
    _isLoading = true;
    // Print.yellow('||| fired fetchNextChunk');
    var res = await fetch(
      greaterThan: null,
      lessThan:
          oldestTimestamp == null ? null : DateTime.fromMillisecondsSinceEpoch(oldestTimestamp),
      employeeUid: null,
      limit: limit,
    );
    if (res.length == 0) _endOfData = true;
    setOldestTimestampFrom(res);
    _cache.addAll(res);
    _notifyRepoUpdates();
    _isLoading = false;
    return res.length;
  }

  //-----------------------------------------
  Future<List<Entry>> fetch({
    @required DateTime greaterThan,
    @required DateTime lessThan,
    @required String employeeUid,
    int limit,
  }) =>
      sqlite.fetch(
        greaterThan: greaterThan?.millisecondsSinceEpoch,
        lessThan: lessThan?.millisecondsSinceEpoch,
        employeeUid: employeeUid,
        limit: limit,
      );

  //-----------------------------------------
  void addOrUpdate(Entry entry) {
    var index = _cache.indexOf(entry);
    if (index >= 0)
      _cache[index] = entry;
    else
      _cache.insert(0, entry);
    sqlite.addOrUpdate(entry);
    _notifyRepoUpdates();
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
    if (_oldest != null) oldestTimestamp = _oldest;
  }

  //-----------------------------------------
  dispose() {
    _streamCtrlCacheUpdates.close();
  }
}
