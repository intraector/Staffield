import 'package:Staffield/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

Future<bool> dialogConfirm(BuildContext context, {String text, String textYes, String textNo}) =>
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                text ?? 'Вы уверены?',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                SimpleDialogOption(
                  child: Text(textYes ?? 'ОК'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
                SimpleDialogOption(
                  child: Text(textNo ?? 'ОТМЕНА'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ));
