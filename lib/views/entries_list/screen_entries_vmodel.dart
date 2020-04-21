import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/views/entries_list/model_entries_list_item.dart';

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
  int recordsPerScreen = 10;
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
}
