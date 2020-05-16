import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/services/services_manager.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_entries_adapter.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_penalty_types_adapter.dart';
import 'package:Staffield/views/entries/screen_entries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_employees.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:get_it/get_it.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/services/router.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Router.createRoutes();
  final getIt = GetIt.instance;
  getIt.registerSingleton<SrvcSqliteInit>(SrvcSqliteInit());
  getIt.registerSingleton<ServicesManager>(ServicesManager());
  getIt.registerSingleton<PenaltyTypesRepository>(
      PenaltyTypesRepository(SrvcSqlitePenaltyTypesAdapter()));
  getIt.registerSingleton<EmployeesRepository>(EmployeesRepository(SrvcSqliteEmployees()));
  getIt.registerSingleton<EntriesRepository>(EntriesRepository(SqliteEntriesAdapater()));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      title: 'Staffield',
      navigatorKey: Router.sailor.navigatorKey,
      onGenerateRoute: Router.sailor.generator(),
      home: ScreenEntries(),
      theme: ThemeData(
        textTheme: TextTheme(
          headline1:
              GoogleFonts.manrope(fontSize: 95, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2:
              GoogleFonts.manrope(fontSize: 59, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3: GoogleFonts.manrope(fontSize: 48, fontWeight: FontWeight.w400),
          headline4:
              GoogleFonts.manrope(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headline5: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.w400),
          headline6:
              GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle1:
              GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          subtitle2:
              GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText2:
              GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyText1:
              GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          button:
              GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          caption:
              GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          overline:
              GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ),
      ),
    ),
  );
}

// final ThemeData _kShrineTheme = _buildShrineTheme();

// ThemeData _buildShrineTheme() {
//   final ThemeData base = ThemeData.light();
//   return base.copyWith(
//     primaryColor: AppColors.kShrinePurple,
//     buttonTheme: base.buttonTheme.copyWith(
//         buttonColor: AppColors.kShrinePurple,
//         textTheme: ButtonTextTheme.primary,
//         colorScheme: ColorScheme.light().copyWith(primary: AppColors.kShrinePurple)),
//     scaffoldBackgroundColor: AppColors.kShrineSurfaceWhite,
//     textTheme: _buildShrineTextTheme(base.textTheme),
//     primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
//     accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
//     primaryIconTheme: base.iconTheme.copyWith(color: AppColors.kShrineSurfaceWhite),
//   );
// }

// TextTheme _buildShrineTextTheme(TextTheme base) {
//   return base
//       .copyWith(
//         headline5: base.headline5.copyWith(
//           fontWeight: FontWeight.w500,
//         ),
//         headline6: base.headline6.copyWith(fontSize: 18.0),
//         caption: base.caption.copyWith(
//           fontWeight: FontWeight.w400,
//           fontSize: 14.0,
//         ),
//       )
//       .apply(
//         fontFamily: 'Raleway',
//       );
// }
