import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/views/penalty_types/screen_penalty_types_vmodel.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenPenaltyTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: ViewDrawer(),
        bottomNavigationBar: BottomNavigation(RouterPaths.penaltyTypes),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          child: Icon(Icons.add),
          onPressed: () => Router.sailor.navigate(
            RouterPaths.editPenaltyType,
            params: {'penaltyType': PenaltyType()},
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
            SliverAppBar(
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("ШАБЛОНЫ ШТРАФОВ",
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
                  "https://tatarstan.ru/rus/file/news/421_1246434_big.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: ChangeNotifierProvider(
                  create: (_) => PenaltyTypesVModel(),
                  child: Consumer<PenaltyTypesVModel>(
                    builder: (_, vModel, __) => ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: vModel.cache.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => Router.sailor.navigate(
                          RouterPaths.editPenaltyType,
                          params: {'penaltyType': vModel.cache[index]},
                        ),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  vModel.cache[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16.0),
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                )),
                                Icon(Icons.chevron_right, size: 20),
                                // Text(employee.uid),
                              ],
                            ),
                          ),
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
    );
  }
}
