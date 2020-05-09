import 'package:Staffield/constants/app_font_family.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle get titleDisplay =>
      TextStyle(fontSize: AppFontSize.h5, color: AppColors.primaryAccent);

  static TextStyle get drawer => TextStyle(fontSize: AppFontSize.body1, color: AppColors.primary);

  static TextStyle get textLabel =>
      TextStyle(fontSize: AppFontSize.body1, color: AppColors.primaryAccent);

  static TextStyle get small1Light => TextStyle(fontSize: AppFontSize.body1, color: Colors.white);

  static TextStyle get body => TextStyle(
        fontFamily: AppFontFamily.ptsans,
        fontSize: AppFontSize.body1,
        color: AppColors.primary,
      );

  static TextStyle get bodyBold => TextStyle(
        fontFamily: AppFontFamily.nunito,
        fontSize: AppFontSize.body1,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get digitsBold => GoogleFonts.ptSans(
        fontSize: AppFontSize.title1,
        fontWeight: FontWeight.bold,
      );
  //  TextStyle(
  //       fontFamily: AppFontFamily.ptsans,
  //       fontSize: AppFontSize.title1,
  //       color: AppColors.black,
  //       fontWeight: FontWeight.bold,
  //     );

  static TextStyle get dataChipLabel => TextStyle(
        fontFamily: AppFontFamily.comfortaa,
        fontSize: AppFontSize.tiny1,
        color: AppColors.black,
      );

  static TextStyle get smallBold => TextStyle(
        fontSize: AppFontSize.body2,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyBoldLight => TextStyle(
        fontFamily: AppFontFamily.ptsans,
        fontSize: AppFontSize.body1,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get buttonLabelOutline =>
      TextStyle(fontSize: AppFontSize.small1, color: AppColors.primary);

  static TextStyle get dateLabel => TextStyle(
        fontFamily: AppFontFamily.ptsans,
        fontSize: AppFontSize.body1,
        color: AppColors.primaryBlend,
      );

  static TextStyle get button => TextStyle(fontSize: AppFontSize.body2, color: Colors.white);
}
