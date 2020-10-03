import 'package:Staffield/core/entities/penalty_type.dart';
import 'package:Staffield/views/edit_penalty_type/screen_edit_penalty_type.dart';
import 'package:Staffield/views/employees/view_employees.dart';
import 'package:Staffield/views/penalty_types/screen_penalty_types.dart';
import 'package:Staffield/views/reports/view_reports.dart';
import 'package:Staffield/views/startup/view_startup.dart';
import 'package:flutter/animation.dart';
import 'package:sailor/sailor.dart';
import 'package:Staffield/constants/routes_paths.dart';
import 'package:Staffield/views/entries/view_entries.dart';
import 'package:Staffield/views/edit_entry/view_edit_entry.dart';

class Routes {
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
      SailorRoute(name: RoutesPaths.startup, builder: (_, __, ___) => ViewStartup()),
      SailorRoute(name: RoutesPaths.entries, builder: (_, __, ___) => ViewEntries()),
      SailorRoute(
        name: RoutesPaths.editEntry,
        builder: (_, __, params) => ViewEditEntry(params.param<String>('entry_uid')),
        params: [SailorParam<String>(name: 'entry_uid')],
      ),
      SailorRoute(
        name: RoutesPaths.editPenaltyType,
        builder: (_, __, params) => ScreenEditPenaltyType(params.param<PenaltyType>('penaltyType')),
        params: [SailorParam<PenaltyType>(name: 'penaltyType')],
      ),
      SailorRoute(name: RoutesPaths.employees, builder: (_, __, ___) => ViewEmployees()),
      SailorRoute(name: RoutesPaths.reports, builder: (_, __, ___) => ViewReports()),
      SailorRoute(name: RoutesPaths.penaltyTypes, builder: (_, __, ___) => ScreenPenaltyTypes()),
    ]);
  }
}
