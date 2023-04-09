import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/data/colors/level_color.dart';
import 'package:sudoku_classic/app/modules/home/views/home_view.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return EasySplashScreen(
      logo: Image.asset(
          'assets/icon/icon_foreground.png'),
      // title: const Text(
      //   "Title",
      //   style: TextStyle(
      //     fontSize: 18,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      backgroundColor: LevelColor.backgroundColor,
      showLoader: false,
      loadingText: const Text("Loading...",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      navigator: const HomeView(),
      durationInSeconds: 3,
    );
  }
}
