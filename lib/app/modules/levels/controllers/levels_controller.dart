import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/modules/profile/controllers/profile_controller.dart';

class LevelsController extends GetxController {
 late ProfileController profileController;
 late TabController tabController;

 @override
  void onInit() {
    profileController=Get.find<ProfileController>();
  
    super.onInit();
  }
}
