import 'package:flutter/material.dart';
import 'package:mydirectcash/Controllers/UserController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('en');

  Locale get appLocal => _appLocale;
  fetchLocale() async {
    UserController().sharedPreferences().then((value) {
      if (value.getString('language_code') == null) {
        changeLanguage(const Locale("en"));

        _appLocale = const Locale('en');
        print(value.getString('language_code') == null);
        return Null;
      }
      _appLocale = Locale('${value.getString('language_code')}');
      return Null;
    });
  }

  void changeLanguage(Locale type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("fr")) {
      _appLocale = const Locale("fr");
      await prefs.setString('language_code', 'fr');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
