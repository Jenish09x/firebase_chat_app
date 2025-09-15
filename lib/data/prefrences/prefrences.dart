import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  Preference._();

  static final Preference _instance = Preference._();

  factory Preference() => _instance;

  SharedPreferences? prefs;

  static const String _keyIsLoggedIn = 'is_logged_in';

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  set isLogin(bool status) => prefs?.setBool(_keyIsLoggedIn, status);

  bool get isLogin => prefs?.getBool(_keyIsLoggedIn) ?? false;

  void clear() {
    prefs?.clear();
  }
}
