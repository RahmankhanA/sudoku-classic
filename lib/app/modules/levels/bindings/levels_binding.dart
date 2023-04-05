import 'package:get/get.dart';

import '../controllers/levels_controller.dart';

class LevelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LevelsController>(
      () => LevelsController(),
    );
  }
}
