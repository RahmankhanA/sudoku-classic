import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/data/colors/level_color.dart';

// import 'package:sudoku_classic/app/modules/game/sudoku.dart';
// import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

import '../controllers/game_controller.dart';

class GameView extends GetView<GameController> {
  const GameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sudoku "),
        centerTitle: true,
        actions: [
          Obx(() => Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  controller.time.value,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    controller.generateSudoku(emptySpace: 27);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reset"),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.lightbulb_outline_rounded),
                  label: const Text("Hint"),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  label: const Text("3 Life"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder(
                init: controller,
                initState: (_) {},
                builder: (_) {
                  return Table(
                    border: TableBorder.all(
                        // color: Colors.deepPurple
                        ),
                    children: List.generate(
                      9,
                      (rowIndex) => TableRow(
                        children: List.generate(
                          9,
                          (colIndex) => GestureDetector(
                              onTap: () {
                                controller.rowSelected = rowIndex;
                                controller.colSelected = colIndex;
                                controller.update();
                              },
                              child: Container(
                                height: 37,
                                width: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: (controller.colSelected ==
                                                colIndex &&
                                            controller.rowSelected == rowIndex)
                                        ? Colors.cyan
                                        : (controller.colSelected == colIndex ||
                                                controller.rowSelected ==
                                                    rowIndex)
                                            ? Colors.lightBlue
                                            : rowIndex < 3 &&
                                                        (colIndex < 3 ||
                                                            colIndex > 5) ||
                                                    (rowIndex > 2 &&
                                                        rowIndex < 6 &&
                                                        colIndex > 2 &&
                                                        colIndex < 6)||(rowIndex>5&& ((colIndex < 3 ||
                                                            colIndex > 5)))
                                                ? Colors.grey
                                                : LevelColor.backgroundColor),
                                // row<3 &&( col<3 || col>5)/
                                child: Center(
                                  child: Text(
                                    controller.puzzle[rowIndex][colIndex] == 0
                                        ? " "
                                        : controller.puzzle[rowIndex][colIndex]
                                            .toString(),
                                  ),
                                  // child: Text(' '),
                                ),
                              )),
                        ),
                      ),
                    ),
                  );
                  // return Table(
                  //   border: TableBorder.all(
                  //     color: Colors.deepPurple
                  //   ),
                  //   children: List.generate(
                  //     9,
                  //     (rowIndex) => TableRow(

                  //       children: List.generate(
                  //         9,
                  //         (colIndex) => GestureDetector(
                  //             onTap: () {
                  //               controller.rowSelected = rowIndex;
                  //               controller.colSelected = colIndex;
                  //               controller.update();
                  //             },
                  //             child: Container(
                  //               height: 37,
                  //               width: 30,
                  //               decoration: BoxDecoration(
                  //                   border: Border.all(),
                  //                   color: (controller.colSelected ==
                  //                               colIndex ||
                  //                           controller.rowSelected == rowIndex)
                  //                       ? Colors.blue
                  //                       : LevelColor.backgroundColor),
                  //               child: Center(
                  //                 child: Text(
                  //                   controller.puzzle[rowIndex][colIndex] == 0
                  //                       ? " "
                  //                       : controller.puzzle[rowIndex][colIndex]
                  //                           .toString(),
                  //                 ),
                  //                 // child: Text(' '),
                  //               ),
                  //             )),
                  //       ),
                  //     ),
                  //   ),
                  // );
                  // return Table(
                  //   border: TableBorder.all(
                  //     color: Colors.deepPurple
                  //   ),
                  //   children: List.generate(
                  //     9,
                  //     (rowIndex) => TableRow(

                  //       children: List.generate(
                  //         9,
                  //         (colIndex) => GestureDetector(
                  //             onTap: () {
                  //               controller.rowSelected = rowIndex;
                  //               controller.colSelected = colIndex;
                  //               controller.update();
                  //             },
                  //             child: Container(
                  //               height: 37,
                  //               width: 30,
                  //               decoration: BoxDecoration(
                  //                   border: Border.all(),
                  //                   color: (controller.colSelected ==
                  //                               colIndex ||
                  //                           controller.rowSelected == rowIndex)
                  //                       ? Colors.blue
                  //                       : LevelColor.backgroundColor),
                  //               child: Center(
                  //                 child: Text(
                  //                   controller.puzzle[rowIndex][colIndex] == 0
                  //                       ? " "
                  //                       : controller.puzzle[rowIndex][colIndex]
                  //                           .toString(),
                  //                 ),
                  //                 // child: Text(' '),
                  //               ),
                  //             )),
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ),
          //  for (int i = 0; i < 9; i++)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       for (int j = 0; j < 9; j++)

          // Container(
          //   height: 35,
          //   width: 35,
          //   color: Colors.red,
          //   margin: const EdgeInsets.all(2),
          // )
          //     ],
          //   ),
          SizedBox(
            height: 130,
            width: 400,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return index ==
                          9 // if index is 10 , then show delete button else show normal number button.
                      ? ElevatedButton.icon(
                          // !---------Delete number button----------!
                          onPressed: () {
                            // setState(() {
                            //   sudokuGrid[rowSelected][colSelected] = 0;
                            //   UserInputNumbers[rowSelected][colSelected] =
                            //       false;
                            // });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(5),
                          ),
                          icon: const Icon(Icons.delete),
                          label: const Text(''),
                        )
                      : ElevatedButton.icon(
                          // !---------Normal number button----------!
                          onPressed: () {
                            // setState(() {
                            //   sudokuGrid[rowSelected][colSelected] =
                            //       index + 1;
                            //   UserInputNumbers[rowSelected][colSelected] =
                            //       true;
                            // });
                          },
                          icon: Text(
                            '${index + 1}',
                            style: const TextStyle(fontSize: 25),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(5),
                          ),
                          label: Text(
                            index.toString(),
                            textAlign: TextAlign.end,
                            textScaleFactor: 0.78,
                          ),
                          // child: Text(
                          //   '${index + 1}',
                          //   style: const TextStyle(fontSize: 25),
                          // ),
                        );
                },
                itemCount: 10),
          ),
        ],
      ),
    );
  }
}
