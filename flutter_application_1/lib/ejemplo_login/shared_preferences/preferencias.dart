import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _prefs;

  static String _name = '';
  static bool _isDarkmode = false;

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
  }



}

class SharedPreferences {
  static getInstance() {}
}