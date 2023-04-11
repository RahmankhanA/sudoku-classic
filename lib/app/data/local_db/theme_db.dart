import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataBase {
  String themeKey = "ThemeKey";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  setTheme(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(themeKey, value);
  }

  Future<bool> getTheme() async {
    final SharedPreferences prefs = await _prefs;
    var res = prefs.getBool(themeKey);
    if (res != null) {
      return res;
    }
    return false;
  }
}
