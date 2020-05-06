import 'package:Staffield/constants/app_gradients.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  GradientButton({@required this.label, @required this.onPressed});
  final String label;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) => InkWell(
        child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              gradient: AppGradients.solidStone,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(label, style: AppTextStyles.button)),
        onTap: onPressed,
      );
}
