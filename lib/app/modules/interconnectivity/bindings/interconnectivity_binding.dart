import 'package:get/get.dart';

import '../controllers/interconnectivity_controller.dart';

class InterconnectivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InterconnectivityController>(
      () => InterconnectivityController(),
    );
  }
}
