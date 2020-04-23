import 'package:Staffield/views/employees/screen_employees.dart';
import 'package:flutter/animation.dart';
import 'package:sailor/sailor.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/views/entries/screen_entries.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry.dart';

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
      SailorRoute(name: RouterPaths.entriesList, builder: (_, __, ___) => ScreenEntries()),
      SailorRoute(
        name: RouterPaths.editEntry,
        builder: (_, __, params) => ScreenEditEntry(params.param<String>('entry_uid')),
        params: [SailorParam<String>(name: 'entry_uid')],
      ),
      SailorRoute(name: RouterPaths.employees, builder: (_, __, ___) => ScreenEmployees()),
      // SailorRoute(
      //   name: RouterPaths.editEmployee,
      //   builder: (_, __, params) => DialogEditEmployee(params.param<String>('employee_uid')),
      //   params: [SailorParam<String>(name: 'employee_uid')],
      // ),
    ]);
  }
}
