import 'package:Staffield/services/services_manager.dart';
import 'package:Staffield/views/employees/screen_employees.dart';
import 'package:Staffield/views/entries_list/screen_entries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_employees.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_entries.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Router.createRoutes();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      title: 'Staffield',
      navigatorKey: Router.sailor.navigatorKey,
      onGenerateRoute: Router.sailor.generator(),
      home: Injector(inject: [
        Inject<SrvcSqliteInit>(() => SrvcSqliteInit()),
        Inject<ServicesManager>(() => ServicesManager(), isLazy: false),
        Inject<EntriesRepository>(() => EntriesRepository(SrvcSqliteEntries())),
        Inject<EmployeesRepository>(() => EmployeesRepository(SrvcSqliteEmployees())),
      ], builder: (_) => ScreenEntriesList()),
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
            buttonColor: AppColors.primary,
            textTheme: ButtonTextTheme.primary,
            highlightColor: AppColors.secondaryAccent),
        primaryColor: AppColors.primary,
        backgroundColor: AppColors.background,
        dialogBackgroundColor: AppColors.background,
        errorColor: AppColors.error,
        scaffoldBackgroundColor: AppColors.background,
        cardColor: Colors.white,
        indicatorColor: AppColors.secondary,
        buttonColor: AppColors.secondary,
        bottomAppBarColor: AppColors.background,
        textSelectionHandleColor: AppColors.secondary,
        textSelectionColor: AppColors.secondary,
        toggleableActiveColor: AppColors.secondaryAccent,
        textTheme: TextTheme(
            display4: TextStyle(fontSize: 24.0),
            display3: TextStyle(fontSize: 22.0),
            display2: TextStyle(fontSize: 20.0),
            display1: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
            headline: TextStyle(fontSize: 18.0),
            title: TextStyle(fontSize: 17.0),
            subhead: TextStyle(fontSize: 16.0),
            body2: TextStyle(fontSize: 15.0),
            body1: TextStyle(fontSize: 14.0),
            caption: TextStyle(fontSize: 12.0),
            subtitle: TextStyle(fontSize: 11.0),
            button: TextStyle(color: Colors.teal[700]),
            overline: TextStyle(fontSize: 10.0)),
      ),
    ),
  );
}
