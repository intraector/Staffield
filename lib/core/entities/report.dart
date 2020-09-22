import 'package:Staffield/core/entities/penalty_report.dart';
import 'package:Staffield/core/entities/entry.dart';
import 'package:jiffy/jiffy.dart';

class Report extends Entry {
  Report();
  Report.dateLabel(int timestamp) {
    isDateLabel = true;
    dateLabel = Jiffy(DateTime.fromMillisecondsSinceEpoch(timestamp)).MMMMd;
    // dateLabel = timeAndDifference(timestamp1: timestamp, showDate: true, showYear: true);
  }

  bool isDateLabel = false;
  String dateLabel = '';
  var penaltiesReports = <PenaltyReport>[];
  int penaltiesCount = 0;
  double bonus;
  double penaltyUnit = 0;
  Map<String, double> penaltiesTotalByType = {};
  double penaltiesTotal = 0.0;

  //-----------------------------------------
  @override
  String toString() {
    return super.toString() +
        ' penaltiesCount: $penaltiesCount, penaltiesTotalByType: $penaltiesTotalByType';
  }
}
