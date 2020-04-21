import 'dart:async';

import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/models/entry.dart';

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
  void add(Entry entry) {
    _repo.add(entry);
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
  void remove(Entry entry) {
    var index = _repo.indexOf(entry);
    if (index >= 0) _repo.removeAt(index);
    sqlite.remove(entry.uid);
    _notifyRepoUpdates();
  }

  //-----------------------------------------
  void update(Entry entry) {
    var index = _repo.indexOf(entry);
    if (index >= 0) _repo[index] = entry;
    _notifyRepoUpdates();
  }

  dispose() {
    _streamCtrlRepoUpdates.close();
  }
}
