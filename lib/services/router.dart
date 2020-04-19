import 'package:flutter/animation.dart';
import 'package:sailor/sailor.dart';
import 'package:staff_time/constants/sailor_paths.dart';
import 'package:staff_time/views/entries_list/screen_entries_list.dart';
import 'package:staff_time/views/new_entry/screen_entry.dart';

class Router {
  static final sailor = Sailor(
    options: SailorOptions(
      handleNameNotFoundUI: true,
      defaultTransitions: [SailorTransition.fade_in],
      defaultTransitionCurve: Curves.linear,
      defaultTransitionDuration: Duration(milliseconds: 0),
    ),
  );

  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(name: SailorPaths.entriesList, builder: (_, __, ___) => ScreenEntriesList()),
      SailorRoute(
        name: SailorPaths.newEntry,
        builder: (_, __, params) => ScreenEntry(params.param<String>('entry_uid')),
        params: [SailorParam<String>(name: 'entry_uid')],
      ),
    ]);
  }
}
