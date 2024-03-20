import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {
  static final SharedPreferencesData _instance =
      SharedPreferencesData._internal();

  factory SharedPreferencesData() {
    return _instance;
  }

  SharedPreferencesData._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET & SET - FAVORITE LIST
  String get reservaList {
    return _prefs.getString('reservaList') ?? '';
  }

  set reservaList(String value) {
    _prefs.setString('reservaList', (value));
  }

  // PREFERENCES CLEAR
  Future<bool> preferencesClear() {
    return _prefs.clear();
  }
}
