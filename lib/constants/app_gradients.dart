import 'package:flutter/material.dart';

class AppGradients {
  static LinearGradient tmp = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color.fromRGBO(15, 20, 26, 1), Color(0xFF9B9D9F)]);

  static LinearGradient tameer = LinearGradient(
      begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: AppGradientsColors.tameer);

  static LinearGradient halfTameer = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: AppGradientsColors.halfTameer,
    // stops: [0.0, 0.5],
  );

  static LinearGradient blueGreyish = LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: AppGradientsColors.blueGreyish);

  static LinearGradient blueBlueish = LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: AppGradientsColors.blueBlueish);

  static LinearGradient lightBlack = LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: AppGradientsColors.lightBlack);

  static LinearGradient mirage = LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: AppGradientsColors.mirage);

  static LinearGradient jungle = LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: AppGradientsColors.jungle);

  static LinearGradient solidStone = LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: AppGradientsColors.solidStone);

  static LinearGradient strongStick = LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: AppGradientsColors.strongStick);

  static LinearGradient viciousStance = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: AppGradientsColors.viciousStance);
}

//-----------------------------------------
class AppGradientsColors {
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
}
