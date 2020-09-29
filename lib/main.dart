import 'package:Staffield/core/service_locator.dart';
import 'package:Staffield/views/startup/view_startup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Staffield/constants/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

Future<void> main() async {
  await Jiffy.locale("ru_RU");
  WidgetsFlutterBinding.ensureInitialized();
  Routes.createRoutes();
  serviceLocatorInit();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MaterialApp(
      title: 'Staffield',
      navigatorKey: Routes.sailor.navigatorKey,
      onGenerateRoute: Routes.sailor.generator(),
      home: ViewStartup(),
      theme: ThemeData(
        brightness: Brightness.light,
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
        primaryTextTheme: TextTheme(
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
        // primaryTextTheme:
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
