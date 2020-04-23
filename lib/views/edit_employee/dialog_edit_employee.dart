import 'package:Staffield/views/edit_employee/dialog_employee_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class DialogEditEmployee extends StatelessWidget {
  DialogEditEmployee([this.employeeUid]);

  final String employeeUid;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => DialogEditEmployeeVModel(employeeUid),
        child: Consumer<DialogEditEmployeeVModel>(
          builder: (_, vModel, __) => AlertDialog(
            title: Text(vModel.dialogTitle, textAlign: TextAlign.center),
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: vModel.txtCtrlName,
                        decoration: InputDecoration(
                          labelText: vModel.labelName,
                          counterStyle: TextStyle(color: Colors.transparent),
                        ),
                        maxLines: 1,
                        maxLengthEnforced: true,
                        maxLength: vModel.nameMaxLength,
                        autofocus: true,
                        validator: (_) => vModel.validateName(),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    value: vModel.hideEmployee,
                    title: Text(vModel.labelHideEmployee),
                    onChanged: (isChecked) => vModel.hideEmployee = isChecked,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                          child: Text('ОК'),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              vModel.save();
                              Navigator.of(context).pop(vModel.employee.uid);
                            }
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
