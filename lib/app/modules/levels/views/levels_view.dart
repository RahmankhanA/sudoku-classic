import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/modules/levels/widgets/custome_drawer.dart';
import 'package:sudoku_classic/app/modules/levels/widgets/level_map.dart';

import '../controllers/levels_controller.dart';

class LevelsView extends GetView<LevelsController> {
  const LevelsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      animationDuration: const Duration(seconds: 1),
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Easy",
              ),
              Tab(
                text: "Medium",
              ),
              Tab(
                text: "Hard",
              ),
              Tab(
                text: "Expert",
              ),
            ],
          ),
          title: const Text("Levels"),
          centerTitle: true,
        ),
        body: GetBuilder(
          init: controller.profileController,
          initState: (_) {},
          builder: (_) {
            return TabBarView(
              children: [
                Stack(
                  children: [
                    GameLevelMap(
                      gameType: 'Easy',
                      currentLevel:
                          controller.profileController.user.currentEasyLevel,
                    ),
                    controller.profileController.user.currentEasyLevel > 5
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(size.width * 0.65, 65.0),
                                ),
                                child: Text(
                                  "Continue ${controller.profileController.user.currentEasyLevel}",
                                  style: const TextStyle(fontSize: 25),
                                ),
                                onPressed: () async {
                                  // Get.to(() => const SudokuContent());
                                  await Get.toNamed('/game', arguments: {
                                    "gameLevel": controller.profileController
                                        .user.currentEasyLevel,
                                    "Type": "Easy"
                                  });
                                  controller.profileController.update();
                                },
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
                Stack(
                  children: [
                    GameLevelMap(
                      gameType: 'Medium',
                      currentLevel:
                          controller.profileController.user.currentMediumLevel,
                    ),
                    controller.profileController.user.currentMediumLevel > 5
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(size.width * 0.65, 65.0),
                                ),
                                child: Text(
                                  "Continue ${controller.profileController.user.currentMediumLevel}",
                                  style: const TextStyle(fontSize: 25),
                                ),
                                onPressed: () async {
                                  // Get.to(() => const SudokuContent());
                                  await Get.toNamed('/game', arguments: {
                                    "gameLevel": controller.profileController
                                        .user.currentMediumLevel,
                                    "Type": "Medium"
                                  });
                                  controller.profileController.update();
                                },
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
                Stack(
                  children: [
                    GameLevelMap(
                      gameType: 'Hard',
                      currentLevel:
                          controller.profileController.user.currentHardLevel,
                    ),
                    controller.profileController.user.currentHardLevel > 5
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(size.width * 0.65, 65.0),
                                ),
                                child: Text(
                                  "Continue ${controller.profileController.user.currentHardLevel}",
                                  style: const TextStyle(fontSize: 25),
                                ),
                                onPressed: () async {
                                  // Get.to(() => const SudokuContent());
                                  await Get.toNamed('/game', arguments: {
                                    "gameLevel": controller.profileController
                                        .user.currentHardLevel,
                                    "Type": "Hard"
                                  });
                                  controller.profileController.update();
                                },
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
                Stack(
                  children: [
                    GameLevelMap(
                      gameType: 'Expert',
                      currentLevel:
                          controller.profileController.user.currentExpertLevel,
                    ),
                    controller.profileController.user.currentExpertLevel > 5
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(size.width * 0.65, 65.0),
                                ),
                                child: Text(
                                  "Continue ${controller.profileController.user.currentExpertLevel}",
                                  style: const TextStyle(fontSize: 25),
                                ),
                                onPressed: () async {
                                  // Get.to(() => const SudokuContent());
                                  await Get.toNamed('/game', arguments: {
                                    "gameLevel": controller.profileController
                                        .user.currentExpertLevel,
                                    "Type": "Expert"
                                  });
                                  controller.profileController.update();
                                },
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ],
            );
          },
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
