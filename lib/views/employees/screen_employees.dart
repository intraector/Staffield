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
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          drawer: ViewDrawer(),
          bottomNavigationBar: BottomNavigation(1),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.secondary,
            child: Icon(Icons.add),
            onPressed: () => showDialog(context: context, builder: (_) => DialogEditEmployee()),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
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
                      )),
                ),
              ];
            },
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: ChangeNotifierProvider(
                    create: (_) => ScreenEmployeesVModel(),
                    child: Consumer<ScreenEmployeesVModel>(
                      builder: (_, vModel, __) {
                        return ListView(
                          children: <Widget>[
                            ...vModel.list.map((employee) => InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (_) => DialogEditEmployee(employee.uid)),
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: <Widget>[
                                          Text(employee.name),
                                          // Text(employee.uid),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
