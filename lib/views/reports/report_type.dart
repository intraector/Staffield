enum ReportType {
  listEmployees,
  tableData,
  tableEmployees,
  tableOneEmployeeByMonth,
  tableEntries,
}

extension Title on ReportType {
  String get title {
    String result;
    switch (this) {
      case ReportType.listEmployees:
        result = 'Список по сотрудникам';
        break;
      case ReportType.tableData:
        result = 'Таблица';
        break;
      case ReportType.tableEmployees:
        result = 'Отчет по сотрудникам';
        break;
      case ReportType.tableOneEmployeeByMonth:
        result = 'Отчет по одному сотруднику';
        break;
      case ReportType.tableEntries:
        result = 'Список записей';
        break;
    }
    return result;
  }
}
