enum ReportType {
  byEmployees,
  tableData,
  tableWithStillEmployeeNames,
}

extension Title on ReportType {
  String get title {
    String result;
    switch (this) {
      case ReportType.byEmployees:
        result = 'По сотруднику';
        break;
      case ReportType.tableData:
        result = 'Таблица';
        break;
      case ReportType.tableWithStillEmployeeNames:
        result = 'Отчет за период';
        break;
    }
    return result;
  }
}
