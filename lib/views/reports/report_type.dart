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
        result = 'список по сотрудникам';
        break;
      case ReportType.tableData:
        result = 'таблица';
        break;
      case ReportType.tableEmployees:
        result = 'отчет по сотрудникам';
        break;
      case ReportType.tableOneEmployeeByMonth:
        result = 'отчет по одному сотруднику';
        break;
      case ReportType.tableEntries:
        result = 'список записей';
        break;
    }
    return result;
  }
}
