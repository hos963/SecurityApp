import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

enum PrefKey { UserToken, UsernamePassword ,UserPic,UserCompleteData,Useremailbio,Userpassbio }

class PreferenceUtils {
  static SharedPreferences _prefsInstance  ;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(PrefKey prefKey, [String defValue]) {
    String keyString = describeEnum(prefKey);
    return _prefsInstance.getString(keyString) ?? defValue ?? "";
  }

  static Future<bool> setString(PrefKey prefKey, String value) async {
    var prefs = await _instance;
    String keyString = describeEnum(prefKey);

    return prefs?.setString(keyString, value) ?? Future.value(false);
  }
}
