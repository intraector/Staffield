import 'package:Staffield/views/employees/screen_employees_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:provider/provider.dart';

class ScreenEmployees extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          drawer: ViewDrawer(),
          appBar: AppBar(),
          bottomNavigationBar: BottomNavigation(1),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.secondary,
            child: Icon(Icons.add),
            onPressed: () =>
                Router.sailor.navigate(RouterPaths.newEntry, params: {'entry_uid': null}),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: ChangeNotifierProvider(
                  create: (_) => ScreenEmployeesVModel(),
                  child: Consumer<ScreenEmployeesVModel>(
                    builder: (_, vModel, __) => ListView(
                      children: <Widget>[
                        ...vModel.list.map((employee) => InkWell(
                              onTap: () => Router.sailor.navigate(RouterPaths.newEntry,
                                  params: {'entry_uid': employee.uid}),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: <Widget>[
                                      Text(employee.name),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
