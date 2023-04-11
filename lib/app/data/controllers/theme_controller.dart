// import 'dart:col';

import 'package:get/get.dart';
import 'package:sudoku_classic/app/data/local_db/theme_db.dart';

class ThemeController extends GetxController {
  RxBool isLight = false.obs;

  setTheme({required bool isLight}) {
    this.isLight.value = isLight;
    ThemeDataBase().setTheme(isLight);
  }
}
