import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/constants/router_paths.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation(this._index);
  final int _index;

  @override
  Widget build(BuildContext context) {
    final _inactiveColor = AppColors.primaryAccent;
    final _disabledColor = AppColors.secondary;
    final double _iconSize = 26;
    var _list = <Widget>[];
    //----------------------------------------entries list
    var entriesList = IconButton(
      icon: Icon(CommunityMaterialIcons.format_list_bulleted),
      iconSize: _iconSize,
      disabledColor: _disabledColor,
      color: _inactiveColor,
      onPressed: _index == 0
          ? null
          : () {
              return Router.sailor
                  .navigate(RouterPaths.entriesList, navigationType: NavigationType.pushReplace);
            },
    );
    //----------------------------------------employees
    var employees = IconButton(
      icon: Icon(CommunityMaterialIcons.account_multiple),
      iconSize: _iconSize,
      disabledColor: _disabledColor,
      color: _inactiveColor,
      onPressed: _index == 1
          ? null
          : () {
              return Router.sailor
                  .navigate(RouterPaths.employees, navigationType: NavigationType.pushReplace);
            },
    );

    _list = [entriesList, employees];
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _list,
      ),
    );
  }
}
