import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:sudoku_classic/app/data/colors/level_color.dart';
import 'package:sudoku_classic/app/data/controllers/ads_controller.dart';
import 'package:sudoku_classic/app/modules/game/controllers/game_controller.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;
  final Function onConfirm;

  const ConfirmationDialog(
      {super.key, required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text(
        'Confirmation',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.backspace,
          ),
          label: const Text(
            'Cancel',
            style: TextStyle(
              // color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => onConfirm(),
          icon: const Icon(Icons.done),
          label: const Text(
            'Watch',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomAlert {
  static showConfirmationDialogForWatchAdToEarnHint({required GameController controller}) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          message: 'You don`t have hint \nWatch Ads to earn hint',
          onConfirm: () {
            // do something when user confirms the action
            Get.back();
            if (controller.adsController.isRewardedAdLoaded) {
              controller.adsController.showRewardedAd(isForHint: true, controller: controller);
            } else {
              // Get.bottomSheet(Get.showSnackbar(snackbar))
              controller.adsController.createRewardedAd();
              Get.snackbar('Ads are Not Available', 'Try  Again Later',
                  backgroundColor: LevelColor.levelMapBackgroundColor,
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
        );
      },
    );
  }
  static showConfirmationDialogForWatchAdToEarnLife({required GameController controller}) {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          message: 'You don`t have life \nWatch Ads to increase your chance',
          onConfirm: () {
            // do something when user confirms the action
            Get.back();
            if (controller.adsController.isRewardedAdLoaded) {
              controller.adsController.showRewardedAd(isForHint: false, controller: controller);
            } else {
              // Get.bottomSheet(Get.showSnackbar(snackbar))
              controller.adsController.createRewardedAd();
              Get.snackbar('Ads are Not Available', 'Try  Again Later',
                  backgroundColor: LevelColor.levelMapBackgroundColor,
                  snackPosition: SnackPosition.BOTTOM);

                  gameOver(controller: controller);
            }
          },
        );
      },
    );
  }

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
      barrierDismissible: true,
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
