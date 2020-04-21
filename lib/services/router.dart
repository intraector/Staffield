import 'package:Staffield/views/employees/screen_employees.dart';
import 'package:flutter/animation.dart';
import 'package:sailor/sailor.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/views/entries_list/screen_entries_list.dart';
import 'package:Staffield/views/new_entry/screen_entry.dart';

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
      SailorRoute(name: RouterPaths.entriesList, builder: (_, __, ___) => ScreenEntriesList()),
      SailorRoute(
        name: RouterPaths.newEntry,
        builder: (_, __, params) => ScreenEntry(params.param<String>('entry_uid')),
        params: [SailorParam<String>(name: 'entry_uid')],
      ),
      SailorRoute(name: RouterPaths.employees, builder: (_, __, ___) => ScreenEmployees()),
    ]);
  }
}
