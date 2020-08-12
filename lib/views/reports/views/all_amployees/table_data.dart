import 'package:Staffield/core/models/report.dart';
import 'package:print_color/print_color.dart';

class TableData {
  TableData(List<Report> list) {
    var periodTimestamps = list.map((e) => e.periodTimestamp).toSet().toList()
      ..sort((a, b) => b.compareTo(a));
    for (var periodTimestamp in periodTimestamps) {
      var tempList = list.where((element) => element.periodTimestamp == periodTimestamp).toList();
      var title = tempList.first.periodTitle;
      data[title] = tempList;
    }
    Print.cyan('||| {data.keys} : ${data.keys}');
  }
  Map<String, List<Report>> data = {};
}
