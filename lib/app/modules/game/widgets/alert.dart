import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:sudoku_classic/app/modules/game/controllers/game_controller.dart';

class CustomAlert {
  static Future<void> showWrongInputDialog({required int life}) {
    return Dialogs.materialDialog(
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
      msg: "You can't afford $life more turnovers",
      title: "Wrong Input",
      lottieBuilder: Lottie.asset(
        'assets/animation/levelLoose.json',
        fit: BoxFit.contain,
      ),
      dialogWidth: kIsWeb ? 0.3 : null,
      context: Get.context!,
      barrierDismissible: false,
      // barrierLabel: "some text",

      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Get.back();
          },
          label: const Text('Got It'),
          icon: const Icon(Icons.done),
        ),
      ],
    );
    // showCupertinoDialog(
    //     context: Get.context!,
    //     builder: (context) {
    //       // sound stuff error
    //       // SoundEffect.stuffError();
    //       return CupertinoAlertDialog(
    //         title: const Text("Oops..."),
    //         content:
    //             Text("\nWrong Input\nYou can't afford $life more turnovers"),
    //         actions: [
    //           CupertinoDialogAction(
    //             child: const Text('Got It'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           )
    //         ],
    //       );
    //     });
  }

  static Future<void> gameOver({required GameController controller}) {
    return Dialogs.materialDialog(
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
      msg: 'You Have lost  Level ${controller.currentLevel}',
      title: 'Oops',
      lottieBuilder: Lottie.asset(
        'assets/animation/levelLoose.json',
        fit: BoxFit.contain,
      ),
      dialogWidth: kIsWeb ? 0.3 : null,
      context: Get.context!,
      barrierDismissible: false,
      // barrierLabel: "some text",

      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Get.back();
            Get.back();
          },
          label: const Text('Back'),
          // icon: const Icon(Icons.arrow_back),
          icon: const Icon(Icons.backspace),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Get.back();
            controller.generateSudoku();
          },
          label: const Text('Try Again'),
          icon: const Icon(Icons.done),
        ),
      ],
    );
  }

  static Future<void> gameWon({required GameController controller}) {
    return Dialogs.materialDialog(
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
      msg: 'You Have Completed  Level ${controller.currentLevel - 1} ',
      title: 'Congratulations',
      lottieBuilder: Lottie.asset(
        'assets/animation/levelComplete2.json',
        fit: BoxFit.contain,
      ),
      dialogWidth: kIsWeb ? 0.3 : null,
      context: Get.context!,
      barrierDismissible: false,
      // barrierLabel: "some text",

      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Get.back();
            Get.back();
          },
          label: const Text('Back'),
          // icon: const Icon(Icons.arrow_back),
          icon: const Icon(Icons.backspace),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Get.back();
            controller.generateSudoku();
          },
          label: const Text('Play Next'),
          icon: const Icon(Icons.done),
        ),
      ],
    );
  }
}
