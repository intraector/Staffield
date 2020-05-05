import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sailor/sailor.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/constants/router_paths.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation(this._index);
  final String _index;

  @override
  Widget build(BuildContext context) {
    final _inactiveColor = AppColors.primaryAccent;
    final _disabledColor = AppColors.secondary;
    final double _iconSize = 26;
    var _list = <Widget>[];

    //----------------------------------------entries list
    var entriesList = IconButton(
      icon: Icon(Icons.assignment),
      iconSize: _iconSize,
      disabledColor: _disabledColor,
      color: _inactiveColor,
      onPressed: _index == RouterPaths.entries
          ? null
          : () => Router.sailor
              .navigate(RouterPaths.entries, navigationType: NavigationType.pushReplace),
    );

    //----------------------------------------employees
    var employees = IconButton(
      icon: Icon(MdiIcons.accountMultiple),
      iconSize: _iconSize,
      disabledColor: _disabledColor,
      color: _inactiveColor,
      onPressed: _index == RouterPaths.employees
          ? null
          : () {
              return Router.sailor
                  .navigate(RouterPaths.employees, navigationType: NavigationType.pushReplace);
            },
    );

    //----------------------------------------employees
    var reports = IconButton(
      icon: Icon(MdiIcons.formatListBulleted),
      iconSize: _iconSize,
      disabledColor: _disabledColor,
      color: _inactiveColor,
      onPressed: _index == RouterPaths.reports
          ? null
          : () {
              return Router.sailor
                  .navigate(RouterPaths.reports, navigationType: NavigationType.pushReplace);
            },
    );

    _list = [entriesList, employees, reports];
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _list,
      ),
    );
  }
}
