import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/services/routes.dart';
import 'package:Staffield/services/service_orchestrator.dart';
import 'package:get/get.dart';

class VModelStartup extends GetxController {
  @override
  void onReady() {
    Get.find<ServiceOrchestrator>()
        .initComplete
        .whenComplete(() => Routes.sailor.navigate(RouterPaths.entries));
    super.onReady();
  }
}
