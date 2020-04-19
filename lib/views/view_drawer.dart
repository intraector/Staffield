import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:staff_time/constants/app_text_styles.dart';
import 'package:staff_time/services/router.dart';

class ViewDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _iconSize = 48;
    return Container(
      width: MediaQuery.of(context).size.width / 1.7,
      child: Drawer(
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
              title: Row(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.settings),
                    width: _iconSize,
                    height: _iconSize,
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('НАСТРОЙКИ', style: AppTextStyles.drawer)),
                  ),
                ],
              ),
              onTap: () {
                Router.sailor('ScreenAds',
                    params: {'type': 'junkyard'}, navigationType: NavigationType.pushReplace);
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
