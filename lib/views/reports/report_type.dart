enum ReportType {
  // allEmployees,
  // singleEmployeeOverPeriod,
  // listEmployees,
  // tableEntries,
  fl_charts
}

extension Title on ReportType {
  String get title {
    String result;
    switch (this) {
      case ReportType.fl_charts:
        result = 'fl_charts';
        break;
      // case ReportType.allEmployees:
      //   result = 'по всем сотрудникам';
      //   break;
      // case ReportType.singleEmployeeOverPeriod:
      //   result = 'по одному сотруднику';
      //   break;
      // case ReportType.listEmployees:
      //   result = 'список по сотрудникам';
      //   break;
      // case ReportType.tableEntries:
      //   result = 'список записей';
      //   break;
    }
    return result;
  }
}
