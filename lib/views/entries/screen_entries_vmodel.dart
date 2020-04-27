import 'dart:async';

import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/views/entries/model_entries_list_item.dart';

final getIt = GetIt.instance;

class ScreenEntriesVModel with ChangeNotifier {
  ScreenEntriesVModel() {
    updateList();
    _subsc = _repo.updates.listen((data) {
      updateList();
    });
  }

  StreamSubscription<bool> _subsc;
  var list = <ModelEntriesListItem>[];
  int recordsPerScreen = 1000;
  final _repo = getIt<EntriesRepository>();

  //-----------------------------------------
  void updateList() {
    list = _repo.repo
        .take(recordsPerScreen)
        .map((entry) => ModelEntriesListItem.fromEntry(entry))
        .toList();
    notifyListeners();
  }

  //-----------------------------------------
  @override
  void dispose() {
    _subsc.cancel();
    super.dispose();
  }

  //-----------------------------------------
  void generateRandomEntries({int days, int recordsPerDay}) =>
      _repo.generateRandomEntries(days: days, recordsPerDay: recordsPerDay);

  //-----------------------------------------
  Future<void> refreshDb() async {
    var sqliteInit = getIt<SrvcSqliteInit>();
    await sqliteInit.deleteDb();
    await sqliteInit.init();
  }
}
