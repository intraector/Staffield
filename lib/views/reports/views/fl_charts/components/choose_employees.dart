import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/vmodel_choose_employees.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:smart_select/smart_select.dart';

class ChooseEmployees extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GetBuilder<VModelChooseEmployees>(
        init: VModelChooseEmployees(),
        builder: (vmodel) => SmartSelect<Employee>.multiple(
          title: 'Сотрудники',
          placeholder: 'Выберите',
          modalType: S2ModalType.bottomSheet,
          value: vmodel.selectedEmployees,
          choiceItems: vmodel.employees,
          choiceEmptyBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text('Нет сотрудников'),
          ),
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
              scrollable: false,
              divider: const Divider(height: 1),
              chipBuilder: (_, index) => Chip(
                label: Text(vmodel.selectedEmployees[index].name),
                backgroundColor: vmodel.selectedEmployees[index].color,
              ),
              chipBrightness: Brightness.dark,
            );
          },
          onChange: (state) => vmodel.selectedEmployees = state.value,
        ),
      ),
    );
  }
}
