import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/modules/game/controllers/game_controller.dart';

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

  static void gameOver({required GameController controller}) {
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
                  controller.generateSudoku(emptySpace: 18);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  static void gameWon({required GameController controller}) {

    showCupertinoDialog(
        context: Get.context!,
        builder: (context) {
          // sound stuff error
          // SoundEffect.stuffError();
          return CupertinoAlertDialog(
            title: const Text("Game Over"),
            content: const Text("\nYou are winner of this game "),
            actions: [
              CupertinoDialogAction(
                child: const Text('Play Next'),
                onPressed: () {
                  controller.generateSudoku(emptySpace: 18);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
