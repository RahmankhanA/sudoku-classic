import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/data/colors/level_color.dart';
import 'package:sudoku_classic/app/data/controllers/theme_controller.dart';
import 'package:sudoku_classic/app/data/local_db/theme_db.dart';
import 'package:sudoku_classic/app/data/theme/theme_color_1.dart';
import 'package:sudoku_classic/app/modules/home/controllers/home_controller.dart';
import 'package:sudoku_classic/app/modules/levels/controllers/levels_controller.dart';
import 'package:sudoku_classic/app/modules/profile/controllers/profile_controller.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  ThemeController themeController = Get.put(ThemeController());
  ProfileController profileController = Get.put(ProfileController());
  LevelsController levelController = Get.put(LevelsController());
  themeController.isLight.value = (await ThemeDataBase().getTheme());

  Get.put(HomeController());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((context) {
    runApp(
      GetMaterialApp(
        theme: themeController.isLight.value
            ? CustomeThemeOne().lightTheme
            : CustomeThemeOne().darkTheme,
        debugShowCheckedModeBanner: false,
        title: "Sudoku",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  });
}
