import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:staff_time/constants/app_colors.dart';
import 'package:staff_time/core/entries_repository.dart';
import 'package:staff_time/services/router.dart';
import 'package:staff_time/services/sqlite/srvc_sqlite_api.dart';
import 'package:staff_time/views/entries_list/screen_entries_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Router.createRoutes();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      title: 'staff_time',
      navigatorKey: Router.sailor.navigatorKey,
      onGenerateRoute: Router.sailor.generator(),
      home: Injector(
          inject: [Inject<EntriesRepository>(() => EntriesRepository(SrvcSqliteApi()))],
          builder: (_) => ScreenEntriesList()),
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
