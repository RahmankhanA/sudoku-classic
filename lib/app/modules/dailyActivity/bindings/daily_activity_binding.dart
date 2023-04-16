import 'package:get/get.dart';

import '../controllers/daily_activity_controller.dart';

class DailyActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyActivityController>(
      () => DailyActivityController(),
    );
  }
}
