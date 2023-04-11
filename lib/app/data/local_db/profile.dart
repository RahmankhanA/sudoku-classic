import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_classic/app/modules/profile/model/profile_model.dart';

class ProfileDataBase {
  String key = "profileKey";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
        currentHardLevel: 0,
        currentMediumLevel: 0,
        isEasyLevelPause: false,
        isHardLevelActive: false,
        isHardLevelPause: false,
        isMediumLevelActive: false,
        isMediumLevelPause: false,
      );
      await setUserProfile(user);
      return user;
    }
    return ProfileModel.fromJson(json.decode(data));
    // return ProfileModel.fromJson(json.decode(data));
  }
}
