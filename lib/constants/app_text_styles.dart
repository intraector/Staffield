import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_fonts.dart';

class AppTextStyles {
  static TextStyle get screenTitle =>
      TextStyle(fontSize: AppFonts.body, color: AppColors.background);

  static TextStyle get drawer => TextStyle(fontSize: AppFonts.small1, color: AppColors.primary);

  static TextStyle get textLabel =>
      TextStyle(fontSize: AppFonts.small4, color: AppColors.primaryAccent);

  static TextStyle get small1Light => TextStyle(fontSize: AppFonts.small1, color: Colors.white);

  static TextStyle get body => TextStyle(
        fontFamily: 'PTSans',
        fontSize: AppFonts.body,
        color: AppColors.primary,
      );

  static TextStyle get bodyBold => TextStyle(
        fontSize: AppFonts.body,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get small1Bold => TextStyle(
        fontSize: AppFonts.small1,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyBoldLight => TextStyle(
        fontFamily: 'PTSans',
        fontSize: AppFonts.body,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get buttonLabelOutline =>
      TextStyle(fontSize: AppFonts.small2, color: AppColors.primary);

  static TextStyle get dateLabel => TextStyle(
        fontSize: AppFonts.body,
        color: Colors.white,
        fontFamily: 'PTSans',
      );

  static TextStyle get button => TextStyle(fontSize: AppFonts.small1, color: Colors.white);
}
