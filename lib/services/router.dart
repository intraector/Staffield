import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/views/screen_edit_penalty_type/screen_edit_penalty_type.dart';
import 'package:Staffield/views/employees/screen_employees.dart';
import 'package:Staffield/views/reports/screen_reports.dart';
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
      SailorRoute(name: RouterPaths.entries, builder: (_, __, ___) => ScreenEntries()),
      SailorRoute(
        name: RouterPaths.editEntry,
        builder: (_, __, params) => ScreenEditEntry(params.param<String>('entry_uid')),
        params: [SailorParam<String>(name: 'entry_uid')],
      ),
      SailorRoute(
        name: RouterPaths.editPenaltyType,
        builder: (_, __, params) => ScreenEditPenaltyType(params.param<PenaltyType>('penaltyType')),
        params: [SailorParam<PenaltyType>(name: 'penaltyType')],
      ),
      SailorRoute(name: RouterPaths.employees, builder: (_, __, ___) => ScreenEmployees()),
      SailorRoute(name: RouterPaths.reports, builder: (_, __, ___) => ScreenReports()),
    ]);
  }
}
