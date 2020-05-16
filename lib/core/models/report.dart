class Report {
  Report();
  // Report.dateLabel(int timestamp) {
  //   isDateLabel = true;
  //   dateLabel = timeAndDifference(timestamp1: timestamp, showDate: true);
  // }
  int reportsCount = 0;
  double revenueAverage;
  double totalAverage;
  String employeeNameAux = '';
  double revenue = 0;
  double interest = 0;
  double wage = 0;
  double penaltyUnit = 0;
  double penaltiesTotalAux = 0;
  double total = 0;
  int penaltiesCount = 0;
  // bool isDateLabel = false;
  // String dateLabel = '';
  Map<String, double> penaltiesTotalByType = {};

  // AdaptedEntryReport _adapted;
  // AdaptedReport get adapted {
  //   _adapted ??= AdaptedEntryReport.from(this);
  //   return _adapted;
  // }

  //-----------------------------------------
  @override
  String toString() {
    return ' reportsCount: $reportsCount, penaltiesTotalByType: $penaltiesTotalByType';
  }
}
