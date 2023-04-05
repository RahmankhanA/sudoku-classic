import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:level_map/level_map.dart';
import 'package:sudoku_classic/app/data/colors/level_color.dart';

import '../controllers/levels_controller.dart';

class LevelsView extends GetView<LevelsController> {
  const LevelsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            ],
          ),
          title: const Text("Levels"),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            LevelMap(
              backgroundColor: LevelColor.backgroundColor2,
              levelMapParams: LevelMapParams(
                levelCount: 40,
                currentLevel: 10,
                pathColor: Colors.black,
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
            const Icon(Icons.directions_transit, size: 350),
            const Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
