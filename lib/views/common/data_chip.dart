import 'package:Staffield/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class DataChip extends StatelessWidget {
  DataChip({@required this.value, @required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.dataChipLabel,
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
