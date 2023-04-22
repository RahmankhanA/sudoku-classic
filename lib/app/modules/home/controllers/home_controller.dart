import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:sudoku_classic/app/data/controllers/theme_controller.dart';
import 'package:advanced_in_app_review/advanced_in_app_review.dart';
class HomeController extends GetxController {
  ThemeController themeController = Get.find<ThemeController>();
  final count = 0.obs;

  void increment() => count.value++;

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      // setState(() {
      //   _updateInfo = info;
      // });
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate();
        log('message');
        //       .catchError((e) => log(e.toString()));
        // InAppUpdate.startFlexibleUpdate().then((_) {
        //   InAppUpdate.performImmediateUpdate()
        //       .catchError((e) => log(e.toString()));
        //   // InAppUpdate.completeFlexibleUpdate().then((_) {
        //   //   log("Success!");
        //   // }).catchError((e) {
        //   //   log(e.toString());
        //   // });
        // }).catchError((e) {
        //   // showSnack(e.toString());
        //   log("message : $e");
        // });
      }
    }).catchError((e) {
      // showSnack(e.toString());
      log("message : $e");
    });
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await AdvancedInAppReview.platformVersion ??
          'Unknown platform version';
          log('platformVersion $platformVersion');
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }
  @override
  void onInit() {
    checkForUpdate();
    initPlatformState();
    AdvancedInAppReview()
        .setMinDaysBeforeRemind(5)
        .setMinDaysAfterInstall(5)
        .setMinLaunchTimes(5)
        .setMinSecondsBeforeShowDialog(5)
        .monitor();

    super.onInit();
  }
}
