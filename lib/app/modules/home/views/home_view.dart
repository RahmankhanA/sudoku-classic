import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/modules/levels/views/levels_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);

    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('HomeView'),
      //   centerTitle: true,
      //   actions: [
      //     Obx(
      //       () => IconButton(
      //         onPressed: () {
      //           controller.themeController.isLight.value =
      //               !controller.themeController.isLight.value;
      //           controller.themeController.setTheme();
      // Get.changeTheme(controller.themeController.isLight.value
      //     ? CustomeThemeOne().lightTheme
      //     : CustomeThemeOne().darkTheme);
      //           // controller.update();
      //         },
      //         icon: Icon(controller.themeController.isLight.value
      //             ? Icons.brightness_2
      //             : Icons.sunny),
      //       ),
      //     )
      //   ],
      // ),
      body: LevelsView(),
    );
  }
}
