import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_fonts.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';

class ChipTotal extends StatelessWidget {
  ChipTotal({@required this.title, @required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.only(top: 5.0),
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        // color: AppColors.primary,
        gradient: FlutterGradients.aboveTheSky(),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: AppFontSize.small, color: AppColors.primary)),
          Text(value, style: AppTextStyles.digitsBold),
        ],
      ));
}
