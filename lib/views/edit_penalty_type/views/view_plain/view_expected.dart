import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_font_family.dart';
import 'package:Staffield/constants/app_fonts.dart';
import 'package:Staffield/views/edit_penalty_type/views/view_plain/view_plain_vmodel.dart';
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
                      child: Text(
                        'Как это будет выглядеть:',
                        // style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(vertical: 20.0),
                            child: Selector<ViewPlainVModel, String>(
                              selector: (_, vModel) => vModel.title.txtCtrl.text,
                              builder: (context, title, child) => Text(
                                title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: AppFontSize.body1, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('СУММА ШТРАФА',
                                          style: TextStyle(
                                            fontFamily: AppFontFamily.comfortaa,
                                            fontSize: AppFontSize.tiny3,
                                            color: AppColors.black,
                                          )),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                                              decoration: BoxDecoration(
                                                  border: Border(bottom: BorderSide(width: 1.0))),
                                              child: Selector<ViewPlainVModel, String>(
                                                selector: (_, vModel) =>
                                                    vModel.defaultValue.txtCtrl.text,
                                                builder: (context, defaultValue, child) => Text(
                                                  defaultValue,
                                                  style: TextStyle(
                                                    fontFamily: AppFontFamily.ptsans,
                                                    fontSize: AppFontSize.small1,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 40.0)),
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
                                                "Отмена",
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
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8)),
                                              child: Text(
                                                'Готово',
                                                style: TextStyle(fontSize: 9.0),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
