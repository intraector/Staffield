import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/views/reports/views/all_amployees/components/vmodel_choose_employees.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:smart_select/smart_select.dart';

class ChooseEmployees extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VModelChooseEmployees>(
      init: VModelChooseEmployees(),
      builder: (vmodel) => SmartSelect<Employee>.multiple(
        title: 'Сотрудники',
        placeholder: 'Выберите',
        value: vmodel.selectedUids,
        choiceItems: vmodel.employees,
        tileBuilder: (context, state) {
          return S2ChipsTile<Employee>(
            title: state.titleWidget,
            values: state.valueObject,
            onTap: state.showModal,
            subtitle: const Text('Выбрать'),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).primaryColor,
            ),
            scrollable: true,
            divider: const Divider(height: 1),
            chipBuilder: (_, index) => Chip(
              label: Text(vmodel.selectedUids[index].name),
              backgroundColor: vmodel.selectedUids[index].color,
            ),
            chipBrightness: Brightness.dark,
          );
        },
        onChange: (state) => vmodel.selectedUids = state.value,
      ),
    );
  }
}
