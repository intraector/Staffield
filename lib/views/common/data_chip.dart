import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_fonts.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class DataChip extends StatelessWidget {
  DataChip({@required this.value, @required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
      // margin: EdgeInsets.all(3.0),
      // decoration: BoxDecoration(
      //   color: Color(0xFF99bdc9),
      //   borderRadius: BorderRadius.circular(5.0),
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: SingleChildScrollView(
              child: Text(
                label,
                style: TextStyle(fontSize: AppFontSize.small, color: AppColors.primary),
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(child: Text(value, style: AppTextStyles.digitsBold)),
          ),
        ],
      ),
    );
  }
}
