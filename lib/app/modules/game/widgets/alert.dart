import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';

class CustomAlert {
  static void showWrongInputDialog({required int life}) {
    showCupertinoDialog(
        context: Get.context!,
        builder: (context) {
          // sound stuff error
          // SoundEffect.stuffError();
          return CupertinoAlertDialog(
            title: const Text("Oops..."),
            content:
                Text("\nWrong Input\nYou can't afford $life more turnovers"),
            actions: [
              CupertinoDialogAction(
                child: const Text('Got It'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  static void gameOver() {
    showCupertinoDialog(
        context: Get.context!,
        builder: (context) {
          // sound stuff error
          // SoundEffect.stuffError();
          return CupertinoAlertDialog(
            title: const Text("Game Over"),
            content: const Text("\nYou have lost this game "),
            actions: [
              CupertinoDialogAction(
                child: const Text('Try Again'),
                onPressed: () {
                  // controller.generateSudoku(emptySpace: 18);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  static Future<void> gameWon() {
    return Dialogs.materialDialog(
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
      msg: 'Congratulations, you won 500 points',
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
          },
          label: const Text('Play Next'),
          icon: const Icon(Icons.done),
        ),
      ],
    );
  }
}
