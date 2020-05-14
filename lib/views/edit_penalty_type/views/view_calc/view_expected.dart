import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_font_family.dart';
import 'package:Staffield/constants/app_fonts.dart';
import 'package:Staffield/views/edit_penalty_type/views/view_calc/view_calc_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewExpected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 14.0, top: 0.0),
                      child: Text('Как это будет выглядеть:'),
                    ),
                  ),
                ],
              ),
              Card(
                margin: EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      child: Selector<ViewCalcVModel, String>(
                        selector: (_, vModel) => vModel.title.txtCtrl.text,
                        builder: (context, titleLabel, _) => Text(
                          titleLabel.toUpperCase(),
                          textAlign: TextAlign.center,
                          // style: TextStyle(
                          //   fontSize: AppFontSize.body1,
                          //   fontWeight: FontWeight.w700,
                          // ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Selector<ViewCalcVModel, String>(
                                  selector: (_, vModel) => vModel.unitLabel.txtCtrl.text,
                                  builder: (context, unitLabel, child) => Text(
                                    unitLabel.toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: AppFontFamily.comfortaa,
                                      fontSize: AppFontSize.tiny3,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                                  decoration:
                                      BoxDecoration(border: Border(bottom: BorderSide(width: 1.0))),
                                  child: Selector<ViewCalcVModel, String>(
                                    selector: (_, vModel) => vModel.unitDefault.txtCtrl.text,
                                    builder: (_, unitDefault, __) => Text(
                                      unitDefault,
                                      style: TextStyle(
                                        fontFamily: AppFontFamily.ptsans,
                                        fontSize: AppFontSize.small1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(Icons.close),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  'ЦЕНА',
                                  style: TextStyle(
                                    fontFamily: AppFontFamily.comfortaa,
                                    fontSize: AppFontSize.tiny3,
                                    color: AppColors.black,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                                  decoration:
                                      BoxDecoration(border: Border(bottom: BorderSide(width: 1.0))),
                                  child: Selector<ViewCalcVModel, String>(
                                    selector: (_, vModel) => vModel.costDefault.txtCtrl.text,
                                    builder: (_, costDefault, __) => Text(
                                      costDefault,
                                      style: TextStyle(
                                        fontFamily: AppFontFamily.ptsans,
                                        fontSize: AppFontSize.small1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'СУММА: ',
                            style: TextStyle(
                              fontFamily: AppFontFamily.comfortaa,
                              fontSize: AppFontSize.tiny3,
                              color: AppColors.black,
                            ),
                          ),
                          Selector<ViewCalcVModel, String>(
                            selector: (_, vModel) => vModel.sum,
                            builder: (_, sum, __) => Text(
                              sum,
                              style: TextStyle(
                                fontFamily: AppFontFamily.ptsans,
                                fontSize: AppFontSize.small1,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5.0),
                          width: 80.0,
                          height: 30,
                          child: FlatButton(
                            padding: EdgeInsets.all(0.0),
                            textColor: Colors.black,
                            child: Text(
                              'ОТМЕНА',
                              style: TextStyle(fontSize: 9.0),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          width: 80.0,
                          height: 30,
                          child: RaisedButton(
                            padding: EdgeInsets.all(0.0),
                            color: AppColors.primary,
                            textColor: AppColors.background,
                            elevation: 3,
                            highlightElevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'ОК',
                              style: TextStyle(fontSize: 9.0),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
