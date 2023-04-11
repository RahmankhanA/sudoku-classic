import 'package:get/get.dart';
import 'package:sudoku_classic/app/data/controllers/theme_controller.dart';
import 'package:sudoku_classic/app/data/local_db/profile.dart';
import 'package:sudoku_classic/app/modules/profile/model/profile_model.dart';

class ProfileController extends GetxController {
  late ProfileModel user;
  ThemeController themeController = Get.find<ThemeController>();

  @override
  void onInit() async {
    user = await ProfileDataBase().getUserProfile();
    super.onInit();
  }



  updateUserProfile(ProfileModel profile){
    ProfileDataBase().setUserProfile(profile);
  }
}
