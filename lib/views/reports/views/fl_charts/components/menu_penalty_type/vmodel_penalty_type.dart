import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/views/reports/vmodel_reports.dart';
import 'package:get/get.dart';

class VModelPenaltyType extends GetxController {
  PenaltyTypesRepository penaltyTypesRepo = Get.find();
  VModelReports vmodel = Get.find();
//-----------------------------------------
  String get penaltyTypeCurrentUid => vmodel.penaltyTypeCurrentUid;
  set penaltyTypeCurrentUid(String value) {
    vmodel.penaltyTypeCurrentUid = value;
    vmodel.fetchReportData();
    update();
  }

  Map<String, String> _penaltiesMenuItems = {
    '111': 'сумма',
    '222': 'количество',
  };

  Map<String, String> get penaltiesMenuItems => _penaltiesMenuItems;

  void generatePenaltiesMenuItems(Set<String> list) {
    _penaltiesMenuItems.clear();
    _penaltiesMenuItems = {
      '111': 'сумма',
      '222': 'количество',
    };
    for (var uid in list) {
      _penaltiesMenuItems[uid] = penaltyTypesRepo.getType(uid).title;
    }
  }
}
