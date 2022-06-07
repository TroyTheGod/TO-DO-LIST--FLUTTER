import 'package:shared_preferences/shared_preferences.dart';

class SettingPreferences {
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static const _keyFirebaseToggle = 'firebaseToggle';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setFirebaseEnable(bool toggle) async {
    await _preferences.setBool(_keyFirebaseToggle, toggle);
    print('setFirebaseEnable.setBool = $toggle');
    print(getFirebaseToggle().toString());
  }

  static bool getFirebaseToggle() =>
      _preferences.getBool(_keyFirebaseToggle) as bool;
}
