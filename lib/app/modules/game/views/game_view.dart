import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sudoku_classic/app/data/colors/level_color.dart';

// import 'package:sudoku_classic/app/modules/game/sudoku.dart';
// import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

import '../controllers/game_controller.dart';

class GameView extends GetView<GameController> {
  const GameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // log(Get.arguments.toString(
    // log(Get.arguments['gameLevel'].toString());
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder(
          init: controller,
          id: 'level',
          initState: (_) {},
          builder: (_) {
            return Text(
                "${controller.gameType} Level ${controller.currentLevel}");
          },
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: GetBuilder(
              init: controller,
              id: 'timer',
              initState: (_) {},
              builder: (_) {
                return Text(
                  controller.time,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    controller.generateSudoku();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reset"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.fillNextHint();
                  },
                  icon: const Icon(Icons.lightbulb_outline_rounded),
                  label: GetBuilder(
                    init: controller,
                    id: 'hint',
                    initState: (_) {},
                    builder: (_) {
                      return Text(
                        "${controller.profileController.user.availableHint} ",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.blue),
                      );
                    },
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  label: Obx(() => Text("${controller.lifeRemain.value} Life")),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                border: TableBorder.all(
                    // color: Colors.deepPurple
                    ),
                children: List.generate(
                  9,
                  (rowIndex) => TableRow(
                    children: List.generate(
                      9,
                      (colIndex) => GetBuilder(
                        init: controller,
                        initState: (_) {},
                        builder: (_) {
                          return GestureDetector(
                            onTap: () {
                              controller.rowSelected = rowIndex;
                              controller.colSelected = colIndex;
                              controller.update();
                            },
                            // onDoubleTap: () {
                            //   // if(controller.sudokuGenerator.newSudoku[])
                            //   print(controller.sudokuGenerator.newSudoku[rowIndex][colIndex]);
                            // },
                            child: Container(
                              height: 37,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(),
                                  color: (controller.colSelected == colIndex &&
                                          controller.rowSelected == rowIndex)
                                      ? Colors.brown[700]
                                      : (controller.colSelected == colIndex ||
                                              controller.rowSelected ==
                                                  rowIndex)
                                          ? theme.primaryColorDark
                                          // ? Colors.brown
                                          : rowIndex < 3 &&
                                                      (colIndex < 3 ||
                                                          colIndex > 5) ||
                                                  (rowIndex > 2 &&
                                                      rowIndex < 6 &&
                                                      colIndex > 2 &&
                                                      colIndex < 6) ||
                                                  (rowIndex > 5 &&
                                                      ((colIndex < 3 ||
                                                          colIndex > 5)))
                                              // ? Colors.deepPurple
                                              ? theme.focusColor
                                              : LevelColor.backgroundColor),
                              // row<3 &&( col<3 || col>5)/
                              child: Center(
                                child: Text(
                                  controller.puzzle[rowIndex][colIndex].value ==
                                          0
                                      ? " "
                                      : controller
                                          .puzzle[rowIndex][colIndex].value
                                          .toString(),
                                  style: TextStyle(
                                    color: !controller
                                            .puzzle[rowIndex][colIndex].isValid
                                        ? Colors.red
                                        : controller.puzzle[rowIndex][colIndex]
                                                .isEditable
                                            ? const Color.fromARGB(
                                                255, 4, 242, 178)
                                            : Colors.white,
                                  ),
                                ),
                                // child: Text(' '),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 130,
            width: 400,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return index ==
                          9 // if index is 10 , then show delete button else show normal number button.
                      ? ElevatedButton(
                          // !---------Delete number button----------!
                          onPressed: () {
                            controller.onPressedDeleteIcon();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(5),
                          ),
                          child: const Icon(
                            Icons.delete,
                            size: 30,
                          ),
                          // label: const Text(''),
                        )
                      : GetBuilder(
                          init: controller,
                          initState: (_) {},
                          builder: (_) {
                            return ElevatedButton.icon(
                              // !---------Normal number button----------!
                              onPressed: () {
                                // controller.selectedNumber = index + 1;
                                // controller.sudokuGenerator.newSudoku[
                                //                   controller.rowSelected]
                                //               [controller.colSelected] ==
                                //           0 &&
                                controller.onPressedNumber(value: index + 1);
                              },
                              icon: Text(
                                '${index + 1}',
                                style: const TextStyle(fontSize: 25),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(5),
                                // backgroundColor:
                                //     controller.selectedNumber == index + 1
                                //         ? theme.shadowColor
                                //         : theme.scaffoldBackgroundColor,
                              ),
                              label: Text(
                                controller.remainingNumberCount[index]
                                    .toString(),
                                textAlign: TextAlign.end,
                                textScaleFactor: 0.78,
                              ),
                              // child: Text(
                              //   '${index + 1}',
                              //   style: const TextStyle(fontSize: 25),
                              // ),
                            );
                          },
                        );
                },
                itemCount: 10),
          ),

          // GetBuilder(builder: )
        ],
      ),
      bottomSheet: GetBuilder(
          init: controller.adsController,
          initState: (_) {},
          id: 'ads',
          builder: (_) {
            return controller.adsController.isHomePageBannerLoaded
                ? SizedBox(
                    // width: controller.adsController.homePageBanner.size.width.toDouble(),
                    // width: MediaQuery.of(context).size.width,
                    height: controller.adsController.homePageBanner.size.height
                        .toDouble(),
                    child:
                        AdWidget(ad: controller.adsController.homePageBanner),
                  )
                : Container(
                  height: 0,
                );
          }),
    );
  }
}
