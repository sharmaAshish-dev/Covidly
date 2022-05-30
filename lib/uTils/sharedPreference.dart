import 'package:shared_preferences/shared_preferences.dart';

class sharedPrefs {
  static addStringToSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static addIntToSF(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static addDoubleToSF(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static addBoolToSF(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(key);
    return stringValue;
  }

  static getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool(key);
    return boolValue;
  }

  static getIntValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt(key);
    return intValue;
  }

  static getDoubleValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    double doubleValue = prefs.getDouble(key);
    return doubleValue;
  }

  static removeValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove(key);
    //Remove bool
    prefs.remove(key);
    //Remove int
    prefs.remove(key);
    //Remove double
    prefs.remove(key);
  }
}
