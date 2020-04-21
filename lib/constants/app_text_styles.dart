import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_fonts.dart';

class AppTextStyles {
  static TextStyle get screenTitle =>
      TextStyle(fontSize: AppFonts.title1, color: AppColors.background);
  static TextStyle get drawer => TextStyle(fontSize: AppFonts.body4, color: AppColors.primary);
  static TextStyle get label1 => TextStyle(fontSize: AppFonts.small1, color: Colors.black);
  static TextStyle get label2 => TextStyle(fontSize: AppFonts.small2, color: Colors.black);
  static TextStyle get dialogCaption =>
      TextStyle(fontSize: AppFonts.title1, color: Colors.grey[900], fontWeight: FontWeight.bold);
  static TextStyle get dialogCaptionInverted =>
      TextStyle(fontSize: AppFonts.title1, color: Colors.black, fontWeight: FontWeight.bold);
  static TextStyle get btnCancelSmall =>
      TextStyle(fontSize: AppFonts.body1, color: AppColors.secondary);
  static TextStyle get btnStandard =>
      TextStyle(fontSize: AppFonts.body3, color: AppColors.secondary);
  static TextStyle get bodyBlend => TextStyle(fontSize: AppFonts.body3, color: AppColors.primary);
  static TextStyle get boldTitle =>
      TextStyle(fontSize: AppFonts.body4, fontWeight: FontWeight.bold);
  static TextStyle get boldTitleBlend => TextStyle(
      fontSize: AppFonts.body3, fontWeight: FontWeight.bold, color: AppColors.primaryAccent);
  static TextStyle get bodyBig =>
      TextStyle(fontSize: AppFonts.title3, color: AppColors.primaryAccent);
  static TextStyle get bodyBig2 =>
      TextStyle(fontSize: AppFonts.title3, color: AppColors.primaryAccent);
}
