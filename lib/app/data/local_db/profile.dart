import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_classic/app/modules/profile/model/profile_model.dart';

class ProfileDataBase {
  String key = "profileKey";
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setUserProfile(ProfileModel user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, json.encode(user.toJson()));
  }

  Future<ProfileModel> getUserProfile() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getString(key);

    if (data == null) {
      final user = ProfileModel(
        score: 0,
        availableHint: 10,
        currentEasyLevel: 1,
        currentHardLevel: 1,
        currentMediumLevel: 1,
        currentExpertLevel: 1,
        isEasyLevelPause: false,
        isHardLevelActive: false,
        isHardLevelPause: false,
        isExpertLevelPause: false,
        isExpertLevelActive: false,
        isMediumLevelActive: false,
        isMediumLevelPause: false,
      );
      await setUserProfile(user);
      return user;
    }
    ProfileModel user;
    try{
      user=ProfileModel.fromJson(json.decode(data));
    }catch (e){
      log(e.toString());
      user= ProfileModel(
        score: 0,
        availableHint: 10,
        currentEasyLevel: 1,
        currentHardLevel: 1,
        currentMediumLevel: 1,
        currentExpertLevel: 1,
        isEasyLevelPause: false,
        isHardLevelActive: false,
        isHardLevelPause: false,
        isExpertLevelPause: false,
        isExpertLevelActive: false,
        isMediumLevelActive: false,
        isMediumLevelPause: false,
      );
      await setUserProfile(user);
    }
    return user;
    // return ProfileModel.fromJson(json.decode(data));
  }
}
