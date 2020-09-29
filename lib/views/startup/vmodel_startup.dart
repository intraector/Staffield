import 'package:Staffield/constants/routes_paths.dart';
import 'package:Staffield/constants/routes.dart';
import 'package:Staffield/services/service_orchestrator.dart';
import 'package:get/get.dart';

class VModelStartup extends GetxController {
  @override
  void onReady() {
    Get.find<OrchestratorSrvc>()
        .initComplete
        .whenComplete(() => Routes.sailor.navigate(RoutesPaths.entries));
    super.onReady();
  }
}
