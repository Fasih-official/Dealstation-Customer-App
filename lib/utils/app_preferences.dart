import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? globalPreferences = null;

class AppPreferences {
  static final String TOKEN = "TOKEN";
  static final String USER_MODEL = "USER_MODEL";
}