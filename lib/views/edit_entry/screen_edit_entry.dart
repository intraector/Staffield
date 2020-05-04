import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:Staffield/utils/dialog_confirm.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:Staffield/views/edit_entry/view_penalties.dart';
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
              body: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/edit_entry.png',
                      color: AppColors.secondary,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                  Column(
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
                                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Selector<ScreenEditEntryVModel,
                                                  Tuple2<String, List<Employee>>>(
                                              selector: (_, _vModel) => Tuple2(
                                                  _vModel.employeeUid, _vModel.employeesItems),
                                              builder: (context, tuple, __) =>
                                                  DropdownButtonFormField(
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
                                                      FocusScope.of(context)
                                                          .requestFocus(focusRevenue);
                                                    },
                                                  )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 20.0),
                                            child: TextFormField(
                                              controller: vModel.txtCtrlRevenue,
                                              textInputAction: TextInputAction.next,
                                              focusNode: focusRevenue,
                                              decoration:
                                                  InputDecoration(labelText: vModel.labelRevenue),
                                              maxLines: 1,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                WhitelistingTextInputFormatter(regexpDigitsAndDot())
                                              ],
                                              onChanged: (_) => vModel.formatRevenue(),
                                              validator: (txt) => vModel.validateRevenue(txt),
                                              onFieldSubmitted: (_) => FocusScope.of(context)
                                                  .requestFocus(focusInterest),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20.0),
                                            child: TextFormField(
                                              controller: vModel.txtCtrlInterest,
                                              focusNode: focusInterest,
                                              decoration:
                                                  InputDecoration(labelText: vModel.labelInterest),
                                              maxLines: 1,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                WhitelistingTextInputFormatter(regexpDigitsAndDot())
                                              ],
                                              onChanged: (_) => vModel.formatInterest(),
                                              validator: (txt) => vModel.validateInterest(txt),
                                              onFieldSubmitted: (_) =>
                                                  FocusScope.of(context).requestFocus(focusWage),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20.0),
                                          child: Selector<ScreenEditEntryVModel, String>(
                                              selector: (_, _vModel) => _vModel.bonus,
                                              builder: (context, bonus, __) => Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(vModel.labelBonus,
                                                          style: AppTextStyles.textLabel),
                                                      Text(bonus, style: AppTextStyles.body),
                                                    ],
                                                  )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            controller: vModel.txtCtrlWage,
                                            textInputAction: TextInputAction.next,
                                            focusNode: focusWage,
                                            decoration:
                                                InputDecoration(labelText: vModel.labelWage),
                                            maxLines: 1,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              WhitelistingTextInputFormatter(regexpDigitsAndDot())
                                            ],
                                            onChanged: (_) => vModel.formatWage(),
                                            validator: (txt) => vModel.validateWage(txt),
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context).requestFocus(focusInterest),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  'ИТОГО: ',
                                                  style: AppTextStyles.bodyBold,
                                                ),
                                                Selector<ScreenEditEntryVModel, String>(
                                                    selector: (_, _vModel) => _vModel.total,
                                                    builder: (context, total, __) => Text(
                                                          total,
                                                          style: AppTextStyles.bodyBold,
                                                        ))
                                              ],
                                            ),
                                          ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
