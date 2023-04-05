// import 'dart:col';

import 'dart:developer';

import 'package:get/get.dart';
import 'package:sudoku_classic/app/data/local_db/theme_db.dart';

class ThemeController extends GetxController {

RxBool isLight=false.obs;


setTheme(){
  log("theme mode isLight : ${isLight.value}");
ThemeDataBase().setTheme(isLight.value);
}

}
