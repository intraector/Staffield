import 'package:Staffield/core/entities/penalty_report.dart';
import 'package:Staffield/core/entities/period_report.dart';
import 'package:Staffield/views/reports/vmodel_reports.dart';
import 'package:flutter/material.dart';

enum ReportCriterion { total, penaltiesTotal, revenue }

class ReportCriterionMapper {
  static final Map<ReportCriterion, String> _criteria = {
    ReportCriterion.total: 'Зарплата',
    ReportCriterion.penaltiesTotal: 'Штрафы',
    ReportCriterion.revenue: 'Выручка',
  };

  static List<DropdownMenuItem<ReportCriterion>> get dropdownItems => _criteria.keys
      .map((key) => DropdownMenuItem(
            value: key,
            child: Text(_criteria[key]),
          ))
      .toList();

  static double value(ReportCriterion criterion, PeriodReport periodReport,
      {String penaltyTypeUid, MenuWageItem auxMenuValue}) {
    double result;
    switch (criterion) {
      case ReportCriterion.total:
        switch (auxMenuValue) {
          case MenuWageItem.bonus:
            result = periodReport.bonus;
            break;
          case MenuWageItem.avg:
            result = periodReport.totalAvg;
            break;
          default:
            result = periodReport.total;
        }

        break;

      case ReportCriterion.penaltiesTotal:
        {
          if (penaltyTypeUid == null || penaltyTypeUid == '111') {
            result = periodReport.penaltiesTotal;
          } else {
            if (penaltyTypeUid == '222') {
              result = periodReport.penaltiesCount.toDouble();
            } else {
              result = periodReport.penalties
                  .firstWhere(
                    (penalty) => penalty.typeUid == penaltyTypeUid,
                    orElse: () => PenaltyReport.empty(),
                  )
                  .total;
            }
          }
        }
        break;

      case ReportCriterion.revenue:
        {
          if (auxMenuValue == MenuWageItem.avg)
            result = periodReport.revenueAvg;
          else
            result = periodReport.revenue;
        }
        break;

      default:
        {
          result = periodReport.penaltiesTotal;
        }
    }
    return result;
  }
}
