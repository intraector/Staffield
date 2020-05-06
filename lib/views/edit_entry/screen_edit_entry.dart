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
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:Staffield/views/edit_entry/view_penalties.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
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
                decoration:
                    BoxDecoration(gradient: FlutterGradients.cloudyApple(tileMode: TileMode.clamp)),
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
                                                  decoration: InputDecoration(isDense: true),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                                              child: Text(
                                                vModel.labelWage,
                                                style: AppTextStyles.smallBold,
                                              ),
                                            ),
                                            EditableWage(
                                              vModel: vModel,
                                              focusNode: focusWage,
                                              nextFocus: focusRevenue,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                                              child: Text(
                                                vModel.labelBonus,
                                                style: AppTextStyles.smallBold,
                                              ),
                                            ),
                                            Selector<ScreenEditEntryVModel, String>(
                                              selector: (_, _vModel) => _vModel.bonus,
                                              builder: (context, bonus, __) => DataChip(
                                                value: bonus,
                                                label: vModel.labelBonus,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                                              child: Text(
                                                vModel.labelPenalties,
                                                style: AppTextStyles.smallBold,
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
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                          child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Text(
                                              vModel.labelRevenue,
                                              style: AppTextStyles.smallBold,
                                            ),
                                          ),
                                          EditableRevenue(
                                            vModel: vModel,
                                            focusNode: focusRevenue,
                                            nextFocus: focusInterest,
                                          ),
                                        ],
                                      )),
                                      Flexible(
                                          child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.0),
                                            child: Text(
                                              vModel.labelInterest,
                                              style: AppTextStyles.smallBold,
                                            ),
                                          ),
                                          EditablInterest(
                                            vModel: vModel,
                                            focusNode: focusInterest,
                                            nextFocus: null,
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
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
                                              items: [
                                                DropdownMenuItem(
                                                    child: Text(PenaltyType.plain.title),
                                                    value: PenaltyType.plain),
                                                DropdownMenuItem(
                                                    child: Text(PenaltyType.timeByMoney.title),
                                                    value: PenaltyType.timeByMoney)
                                              ],
                                              onChanged: (type) =>
                                                  vModel.addPenalty(context, type))),
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
