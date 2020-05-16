import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/views/common/sliver_delegate.dart';
import 'package:Staffield/views/edit_employee/dialog_edit_employee.dart';
import 'package:Staffield/views/employees/screen_employees_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:provider/provider.dart';

class ScreenEmployees extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: ViewDrawer(),
        bottomNavigationBar: BottomNavigation(RouterPaths.employees),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          child: Icon(Icons.add),
          onPressed: () => showDialog(context: context, builder: (_) => DialogEditEmployee()),
        ),
        body: ChangeNotifierProvider(
          create: (_) => ScreenEmployeesVModel(),
          child: Consumer<ScreenEmployeesVModel>(
            builder: (_, vModel, __) => NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                SliverAppBar(
                  expandedHeight: 150.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("СОТРУДНИКИ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 8,
                            ),
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 4,
                            ),
                          ],
                        )),
                    background: Image.network(
                      "https://www.itforum365.com.br/wp-content/uploads/2019/06/rh-cv-compressed.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverAppBarDelegate(
                        minHeight: 44.0,
                        maxHeight: 44.0,
                        child: Container(
                          height: 44.0,
                          decoration: BoxDecoration(
                            color: AppColors.primaryAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                  child: OutlineButton(
                                borderSide: BorderSide(color: AppColors.primaryMiddle),
                                child: Text(vModel.modeButtonLabel,
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: Colors.white)),
                                onPressed: () => vModel.switchMode(),
                              )),
                            ],
                          ),
                        ))),
              ],
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: vModel.list.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (_) => DialogEditEmployee(vModel.list[index].uid)),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: <Widget>[Text(vModel.list[index].name)],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
