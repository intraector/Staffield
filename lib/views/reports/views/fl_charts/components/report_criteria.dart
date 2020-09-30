import 'package:Staffield/core/entities/period_report.dart';
import 'package:flutter/material.dart';

enum ReportCriterion { total, bonus, penaltiesTotal, penaltiesCount, revenue, revenueAvg }

class ReportCriterionMapper {
  static final Map<ReportCriterion, String> _criteria = {
    ReportCriterion.total: 'зарплата',
    ReportCriterion.bonus: 'бонус',
    ReportCriterion.penaltiesTotal: 'штрафы',
    ReportCriterion.penaltiesCount: 'кол-во штрафов',
    ReportCriterion.revenue: 'выручка',
    ReportCriterion.revenueAvg: 'средняя выручка',
  };

  static List<DropdownMenuItem<ReportCriterion>> get dropdownItems => _criteria.keys
      .map((key) => DropdownMenuItem(
            value: key,
            child: Text(_criteria[key]),
          ))
      .toList();

  static double value(ReportCriterion criterion, PeriodReport periodReport) {
    double result;
    switch (criterion) {
      case ReportCriterion.total:
        result = periodReport.total;
        break;
      case ReportCriterion.bonus:
        result = periodReport.bonus;
        break;
      case ReportCriterion.penaltiesTotal:
        result = periodReport.penaltiesTotal;
        break;
      case ReportCriterion.penaltiesCount:
        result = periodReport.penaltiesCount.toDouble();
        break;

      case ReportCriterion.revenue:
        result = periodReport.revenue;
        break;
      case ReportCriterion.revenueAvg:
        result = periodReport.revenueAvg;
        break;
    }
    return result;
  }
}
