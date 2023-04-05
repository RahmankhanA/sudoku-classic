import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sudoku_classic/app/data/controllers/theme_controller.dart';
import 'package:sudoku_classic/app/data/local_db/theme_db.dart';
import 'package:sudoku_classic/app/data/theme/theme_color_1.dart';
import 'package:sudoku_classic/app/modules/home/controllers/home_controller.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {

  ThemeController themeController = Get.put(ThemeController());
  themeController.isLight.value = (await ThemeDataBase().getTheme());
Get.put(HomeController());
  runApp(
    GetMaterialApp(
      // This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
      // theme: CustomeThemeOne().lightTheme,
      theme: themeController.isLight.value
          ? CustomeThemeOne().lightTheme
          : CustomeThemeOne().darkTheme,

//
      // Use dark or light theme based on system setting.
      // themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,

      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
