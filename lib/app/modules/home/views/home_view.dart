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
      //   backgroundColor: Colors.limeAccent,
      // body: LevelMap(
      //   backgroundColor: LevelColor.backgroundColor2,
      //   levelMapParams: LevelMapParams(
      //     levelCount: 40,
      //     currentLevel: 10,
      //     pathColor: Colors.black,
      //     currentLevelImage: ImageParams(
      //       path: "assets/images/current_black.png",
      //       size: const Size(40, 47),
      //     ),
      //     lockedLevelImage: ImageParams(
      //       path: "assets/images/locked_black.png",
      //       size: const Size(40, 42),
      //     ),
      //     completedLevelImage: ImageParams(
      //       path: "assets/images/completed_black.png",
      //       size: const Size(40, 42),
      //     ),
      //     startLevelImage: ImageParams(
      //       path: "assets/images/Boy Study.png",
      //       size: const Size(60, 60),
      //     ),
      //     pathEndImage: ImageParams(
      //       path: "assets/images/Boy Graduation.png",
      //       size: const Size(60, 60),
      //     ),
      //     bgImagesToBePaintedRandomly: [
      //       ImageParams(
      //           path: "assets/images/Energy equivalency.png",
      //           size: const Size(80, 80),
      //           repeatCountPerLevel: 0.5),
      //       ImageParams(
      //           path: "assets/images/Astronomy.png",
      //           size: const Size(80, 80),
      //           repeatCountPerLevel: 0.25),
      //       ImageParams(
      //           path: "assets/images/Atom.png",
      //           size: const Size(80, 80),
      //           repeatCountPerLevel: 0.25),
      //       ImageParams(
      //           path: "assets/images/Certificate.png",
      //           size: const Size(80, 80),
      //           repeatCountPerLevel: 0.25),
      //     ],
      //   ),
      // ),
    );
  }
}
