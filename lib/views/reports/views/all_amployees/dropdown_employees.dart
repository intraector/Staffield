import 'package:Staffield/views/reports/vmodel_view_reports.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class DropdownEmployees extends StatefulWidget {
  DropdownEmployees(this.vmodel);
  final VModelViewReports vmodel;
  @override
  _DropdownEmployeesState createState() => _DropdownEmployeesState();
}

class _DropdownEmployeesState extends State<DropdownEmployees> {
  List<String> value = ['2'];
  List<S2Choice<String>> frameworks = [
    S2Choice<String>(value: '1', title: 'Петя'),
    S2Choice<String>(value: '2', title: 'Вася'),
    S2Choice<String>(value: '3', title: 'Иван Васильевич'),
  ];
  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.multiple(
      title: 'Сотрудники',
      placeholder: 'Выберите',
      value: value,
      choiceItems: frameworks,
      tileBuilder: (context, state) {
        return S2ChipsTile<String>(
          title: state.titleWidget,
          values: state.valueObject,
          onTap: state.showModal,
          subtitle: const Text('lorem impsum'),
          leading: const CircleAvatar(
            backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
          ),
          trailing: const Icon(Icons.add_circle_outline),
          scrollable: true,
          divider: const Divider(height: 1),
          chipColor: Colors.red,
          chipBrightness: Brightness.dark,
        );
      },
      onChange: (state) => setState(() => value = state.value),
    );
  }
}
