import 'dart:io';

import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/views/edit_employee/vmodel_edit_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';

class DialogEditEmployee extends StatelessWidget {
  DialogEditEmployee([this.employee]);

  final Employee employee;
  @override
  Widget build(BuildContext context) => GetBuilder<VModelEditEmployee>(
        init: VModelEditEmployee(employee),
        builder: (vmodel) => PlatformAlertDialog(
          // title: Text(vmodel.dialogTitle, textAlign: TextAlign.center),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                PlatformTextField(
                  cupertino: (_, __) => CupertinoTextFieldData(
                    placeholder: vmodel.labelName,
                    autofocus: true,
                  ),
                  material: (_, __) => MaterialTextFieldData(
                    autofocus: true,
                    decoration: InputDecoration(
                      counter: Container(),
                      labelText: vmodel.labelName,
                      counterStyle: TextStyle(color: Colors.transparent),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  controller: vmodel.txtCtrlName,
                  maxLines: 1,
                  maxLengthEnforced: true,
                  maxLength: vmodel.nameMaxLength,
                  autofocus: true,
                  // validator: (_) => vmodel.validateName(),
                ),
                AnimatedOpacity(
                  opacity: vmodel.errorIsVisible,
                  duration: Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      if (Platform.isIOS) SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              child: Text(
                            'Укажите имя сотрудника',
                            style: TextStyle(color: AppColors.error, fontSize: 14.0),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Выберите цвет: '),
                        Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: vmodel.employee.color,
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      var color = await showDialog<Color>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                availableColors: AppColors.colors,
                                pickerColor: Colors.lime,
                                onColorChanged: (color) {
                                  Navigator.of(context).pop(color);
                                },
                              ),
                            ),
                          );
                        },
                      );
                      vmodel.changeColor(color);
                    },
                  ),
                ),
                if (employee != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(vmodel.labelHideEmployee),
                      PlatformSwitch(
                        onChanged: (isChecked) => vmodel.hideEmployee = isChecked,
                        value: vmodel.hideEmployee,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          actions: [
            PlatformDialogAction(
              child: PlatformText('Отмена'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            PlatformDialogAction(child: Text('OK'), onPressed: () => vmodel.save(context)),
          ],
        ),
      );
}
