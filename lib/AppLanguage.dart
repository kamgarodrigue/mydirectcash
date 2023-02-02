import 'package:flutter/material.dart';
import 'package:mydirectcash/Controllers/UserController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('fr');

  Locale get appLocal => _appLocale;
  fetchLocale() {
    UserController().sharedPreferences().then((value) {
      if (value.getString('language_code') == null) {
        changeLanguage(const Locale("en"));

        _appLocale = const Locale('en');
        print(value.getString('language_code') == null);
      }
      _appLocale = Locale('${value.getString('language_code')}');
      changeLanguage(_appLocale);
      print("lan " + _appLocale.languageCode);
    });
  }

  void changeLanguage(Locale type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      print(_appLocale.languageCode + type.languageCode);
      await prefs.setString('language_code', type.languageCode);
    }
    if (type == const Locale("fr")) {
      _appLocale = const Locale("fr");
      await prefs.setString('language_code', 'fr');
      await prefs.setString('countryCode', '');
    } else if (type == const Locale("en")) {
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    } else {
      _appLocale = const Locale("es");
      await prefs.setString('language_code', 'es');
      await prefs.setString('countryCode', 'ES');
    }
    notifyListeners();
  }
}
