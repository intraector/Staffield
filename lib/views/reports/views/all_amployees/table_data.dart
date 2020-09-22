import 'package:Staffield/core/entities/period_report.dart';

class TableData {
  TableData(List<PeriodReport> list) {
    var periodTimestamps = list.map((e) => e.periodTimestamp).toSet().toList()
      ..sort((a, b) => b.compareTo(a));
    for (var periodTimestamp in periodTimestamps) {
      var tempList = list.where((element) => element.periodTimestamp == periodTimestamp).toList();
      var title = tempList.first.periodTitle;
      data[title] = tempList;
    }
  }
  Map<String, List<PeriodReport>> data = {};
}
