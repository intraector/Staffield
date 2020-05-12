import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/views/common/chip_total.dart';
import 'package:Staffield/views/common/data_chip.dart';
import 'package:Staffield/views/edit_entry/views/editable_interest.dart';
import 'package:Staffield/views/edit_entry/views/editable_revenue.dart';
import 'package:Staffield/views/edit_entry/views/editable_wage.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:Staffield/views/edit_entry/view_penalties.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
// import 'package:Staffield/utils/CurrencyFormatter.dart';

final _formKey = GlobalKey<FormState>();

class ScreenEditEntry extends StatelessWidget {
  ScreenEditEntry([this.entryUid]);
  final focusRevenue = FocusNode();
  final focusWage = FocusNode();
  final focusInterest = FocusNode();
  final String entryUid;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScreenEditEntryVModel(entryUid),
      child: Builder(
        builder: (context) {
          var vModel = Provider.of<ScreenEditEntryVModel>(context, listen: false);
          return SafeArea(
            child: Scaffold(
              drawer: ViewDrawer(),
              bottomNavigationBar: BottomNavigation('nopath'),
              appBar: AppBar(
                title: Text('Запись'),
                actions: <Widget>[
                  IconButton(
                      color: AppColors.error,
                      icon: Icon(Icons.delete),
                      onPressed: () => vModel.removeEntry(context)),
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                    // gradient: FlutterGradients.cloudyApple(tileMode: TileMode.clamp),
                    ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                children: <Widget>[
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Icon(
                                        MdiIcons.fileEdit,
                                        size: 60.0,
                                        color: AppColors.primaryAccent,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'ЗАПИСЬ',
                                          style: AppTextStyles.titleDisplay,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Selector<ScreenEditEntryVModel,
                                                Tuple2<String, List<Employee>>>(
                                            selector: (_, _vModel) =>
                                                Tuple2(_vModel.employeeUid, _vModel.employeesItems),
                                            builder: (context, tuple, __) =>
                                                DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    // labelText: vModel.labelName,
                                                    // labelStyle: AppTextStyles.dataChipLabel,
                                                    hintStyle: AppTextStyles.dataChipLabel,
                                                  ),
                                                  value: tuple.item1,
                                                  hint: Text(vModel.labelName),
                                                  isExpanded: true,
                                                  validator: vModel.validateEmployeeUid,
                                                  items: tuple.item2
                                                      .map((employee) => DropdownMenuItem(
                                                            value: employee.uid,
                                                            child: Text(employee.name),
                                                          ))
                                                      .toList(),
                                                  onChanged: (employeeUid) {
                                                    vModel.setEmployeeUid(employeeUid, context);
                                                    FocusScope.of(context).requestFocus(focusWage);
                                                  },
                                                )),
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.transparent),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 1.5,
                                        child: EditableWage(
                                          focusNode: focusWage,
                                          nextFocus: focusRevenue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.transparent),
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 2,
                                        child: EditableRevenue(
                                          focusNode: focusRevenue,
                                          nextFocus: focusInterest,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: EditablInterest(
                                          vModel: vModel,
                                          focusNode: focusInterest,
                                          nextFocus: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.transparent),
                                  Divider(),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Wrap(
                                          alignment: WrapAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Selector<ScreenEditEntryVModel, String>(
                                              selector: (_, _vModel) => _vModel.bonus,
                                              builder: (context, bonus, __) => DataChip(
                                                value: bonus,
                                                label: vModel.labelBonus,
                                              ),
                                            ),
                                            Selector<ScreenEditEntryVModel, String>(
                                                selector: (_, _vModel) => _vModel.penaltiesTotal,
                                                builder: (context, penaltiesTotal, __) => DataChip(
                                                    value: penaltiesTotal,
                                                    label: vModel.labelPenalties)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Selector<ScreenEditEntryVModel, String>(
                                        selector: (_, _vModel) => _vModel.total,
                                        builder: (context, total, __) =>
                                            ChipTotal(title: 'ИТОГО: ', value: total),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                          margin: const EdgeInsets.only(top: 20.0),
                                          child: DropdownButton<String>(
                                              // icon: Icon(Icons.add),
                                              iconSize: 36,
                                              hint: Text('Добавить штраф'),
                                              items: vModel.penaltyTypesList,
                                              onChanged: (typeUid) {
                                                return vModel.handlePenalty(context, typeUid);
                                              })),
                                    ],
                                  ),
                                  ViewPenalties(Provider.of<ScreenEditEntryVModel>(context)),
                                  Center(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: OutlineButton(
                                                child: Text('НАЗАД',
                                                    style: AppTextStyles.buttonLabelOutline),
                                                onPressed: () => vModel.goBack(context)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RaisedButton(
                                                shape: ContinuousRectangleBorder(
                                                    borderRadius: BorderRadius.circular(48.0)),
                                                child: Text('ОК'),
                                                onPressed: () {
                                                  if (_formKey.currentState.validate()) {
                                                    vModel.save();
                                                    Navigator.of(context).pop();
                                                  }
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
