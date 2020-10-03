import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime> showPlatformDatePicker(BuildContext context, DateTime initialDate) {
  Future<DateTime> output;
  if (Platform.isIOS) {
    output = showDialog<DateTime>(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          DateTime date;
          return CupertinoAlertDialog(
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.maxFinite,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle:
                              TextStyle(fontSize: Theme.of(context).textTheme.bodyText2.fontSize),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: initialDate,
                        maximumDate: DateTime.now(),
                        minimumDate: DateTime(DateTime.now().year - 2),
                        onDateTimeChanged: (value) => date = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text('Отмена'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                  child: Text('OK'), onPressed: () => Navigator.of(context).pop(date)),
            ],
          );
        });
  } else {
    output = showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: initialDate,
    );
  }
  return output;
}
