import 'package:flutter/material.dart';

class AppGradients {
  static LinearGradient tmp = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color.fromRGBO(15, 20, 26, 1), Color(0xFF9B9D9F)]);

  static LinearGradient tameer = LinearGradient(
      begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: AppGradientColors.tameer);

  static LinearGradient halfTameer = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: AppGradientColors.halfTameer);

  static LinearGradient get blueGreyish => _linear(colors: AppGradientColors.blueGreyish);
  static LinearGradient get blueBlueish => _linear(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: AppGradientColors.blueBlueish);
  static LinearGradient get lightBlack => _linear(colors: AppGradientColors.lightBlack);
  static LinearGradient get mirage => _linear(colors: AppGradientColors.mirage);
  static LinearGradient get jungle => _linear(colors: AppGradientColors.jungle);
  static LinearGradient get solidStone => _linear(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: AppGradientColors.solidStone,
        // stops: [0.0, 0.5, 1.0],
      );
  static LinearGradient get strongStick => _linear(colors: AppGradientColors.strongStick);
  static LinearGradient get viciousStance => _linear(colors: AppGradientColors.viciousStance);
  static LinearGradient get moleHole => _linear(colors: AppGradientColors.moleHole);
  static LinearGradient get greyGreyish => _linear(colors: AppGradientColors.greyGreyish);
}

//-----------------------------------------
class AppGradientColors {
  static var tameer = [
    Color(0xff136a8a),
    Color(0xff267871),
  ];
  static var halfTameer = [
    Color(0xFFfee6e6),
    Color(0xFF243949),
  ];

  static var blueGreyish = [
    Color(0xFF2c3e50),
    Color(0xFF5D5D5D),
  ];

  static var blueBlueish = [
    Color(0xFF2c3e50),
    Color(0xFF195E83),
    Color(0xFF2c3e50),
  ];

  static var lightBlack = [
    Color(0xFF232526),
    Color(0xFF414345),
  ];

  static var mirage = [
    Color(0xFF16222A),
    Color(0xFF3A6073),
  ];

  static var jungle = [
    Color(0xFF8BAAAA),
    Color(0xFFAE8B9C),
  ];

  static var solidStone = [
    Color(0xFF243949),
    Color(0xFF517fa4),
    Color(0xFF243949),
  ];

  static var strongStick = [
    Color(0xFFa8caba),
    Color(0xFF5d4157),
  ];

  static var viciousStance = [
    Color(0xFF29323c),
    Color(0xFF485563),
  ];

  static var marble = [
    Color(0xFFe6feea),
    Color(0xFFffffff),
    Color(0xFFfee6e6),
  ];
  static var ivory = [
    Color(0xFFFFFFFF),
    Color(0xFFf1f9f9),
  ];
  static var moleHole = [
    Color(0xFF9bc5c3),
    Color(0xFF616161),
  ];
  static var greyGreyish = [
    Colors.grey[300],
    Colors.white,
  ];
}

LinearGradient _linear({
  AlignmentGeometry begin = Alignment.topLeft,
  AlignmentGeometry end = Alignment.bottomRight,
  List<Color> colors,
  List<double> stops,
  TileMode tileMode = TileMode.clamp,
}) =>
    LinearGradient(begin: begin, end: end, colors: colors, stops: stops, tileMode: tileMode);
