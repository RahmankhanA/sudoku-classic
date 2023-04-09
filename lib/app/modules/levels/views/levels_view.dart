import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:level_map/level_map.dart';

import 'package:sudoku_classic/app/modules/levels/widgets/custome_drawer.dart';

import '../controllers/levels_controller.dart';

class LevelsView extends GetView<LevelsController> {
  const LevelsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.ham),
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
            ],
          ),
          title: const Text("Levels"),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            Stack(
              children: [
                LevelMap(
                  // backgroundColor: theme.primaryColorDark,
                  // backgroundColor: LevelColor.levelMapBackgroundColor,
                  levelMapParams: LevelMapParams(
                    levelCount: 40,
                    currentLevel: 10,
                    pathColor: theme.textTheme.headlineLarge!.color!,
                    currentLevelImage: ImageParams(
                      path: "assets/images/current_black.png",
                      size: const Size(40, 47),
                    ),
                    lockedLevelImage: ImageParams(
                      path: "assets/images/locked_black.png",
                      size: const Size(40, 42),
                    ),
                    completedLevelImage: ImageParams(
                      path: "assets/images/completed_black.png",
                      size: const Size(40, 42),
                    ),
                    startLevelImage: ImageParams(
                      path: "assets/images/Boy Study.png",
                      size: const Size(60, 60),
                    ),
                    pathEndImage: ImageParams(
                      path: "assets/images/Boy Graduation.png",
                      size: const Size(60, 60),
                    ),
                    bgImagesToBePaintedRandomly: [
                      ImageParams(
                          path: "assets/images/Energy equivalency.png",
                          size: const Size(80, 80),
                          repeatCountPerLevel: 0.5),
                      ImageParams(
                          path: "assets/images/Astronomy.png",
                          size: const Size(80, 80),
                          repeatCountPerLevel: 0.25),
                      ImageParams(
                          path: "assets/images/Atom.png",
                          size: const Size(80, 80),
                          repeatCountPerLevel: 0.25),
                      ImageParams(
                          path: "assets/images/Certificate.png",
                          size: const Size(80, 80),
                          repeatCountPerLevel: 0.25),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width * 0.65, 65.0),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(fontSize: 25),
                      ),
                      onPressed: () {
                        // Get.to(() => const SudokuContent());
                        Get.toNamed('/game');
                      },
                    ),
                  ),
                )
              ],
            ),
            const Icon(Icons.abc),
            const Icon(Icons.access_alarm),
          ],
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
