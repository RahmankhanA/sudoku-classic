import 'package:get/get.dart';
import 'package:sudoku_classic/app/data/controllers/theme_controller.dart';

class HomeController extends GetxController {
  // ignore: todo
  //TODO: Implement HomeController
ThemeController themeController = Get.find<ThemeController>();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
