import 'dart:developer';

import 'package:get/get.dart';
import 'package:sudoku_classic/app/data/controllers/theme_controller.dart';

class HomeController extends GetxController {

  ThemeController themeController = Get.find<ThemeController>();
  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();

  }

  void increment() => count.value++;
}
