import 'package:Staffield/constants/app_font_family.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_fonts.dart';

class AppTextStyles {
  static TextStyle get titleDisplay =>
      TextStyle(fontSize: AppFontSize.display, color: AppColors.primaryAccent);

  static TextStyle get drawer => TextStyle(fontSize: AppFontSize.body, color: AppColors.primary);

  static TextStyle get textLabel =>
      TextStyle(fontSize: AppFontSize.body, color: AppColors.primaryAccent);

  static TextStyle get small1Light => TextStyle(fontSize: AppFontSize.body, color: Colors.white);

  static TextStyle get body => TextStyle(
        fontFamily: AppFontFamily.ptsans,
        fontSize: AppFontSize.body,
        color: AppColors.primary,
      );

  static TextStyle get bodyBold => TextStyle(
        fontFamily: AppFontFamily.nunito,
        fontSize: AppFontSize.body,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get digitsBold => TextStyle(
        fontFamily: AppFontFamily.ptsans,
        fontSize: AppFontSize.title,
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get smallBold => TextStyle(
        fontSize: AppFontSize.bodySub,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyBoldLight => TextStyle(
        fontFamily: AppFontFamily.ptsans,
        fontSize: AppFontSize.body,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get buttonLabelOutline =>
      TextStyle(fontSize: AppFontSize.small, color: AppColors.primary);

  static TextStyle get dateLabel => TextStyle(
        fontFamily: AppFontFamily.ptsans,
        fontSize: AppFontSize.body,
        color: AppColors.primaryBlend,
      );

  static TextStyle get button => TextStyle(fontSize: AppFontSize.bodySub, color: Colors.white);
}
//Comfortaa Nunito Ubuntu PTSans
