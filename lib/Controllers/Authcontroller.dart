import 'dart:convert';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mydirectcash/Models/User.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authcontroller extends ControllerMVC {
  factory Authcontroller() {
    if (_this == null) _this = Authcontroller._();
    return _this!;
  }
//export PATH="$PATH:`pwd`/flutter/bin"

  static Authcontroller? _this;

  Authcontroller._();
  static Authcontroller get authController => _this!;
  AuthService auth = new AuthService();
  /* User? userFrombd(User user) {
    return user.data == null ? null : User(data: user.data);
  }

  Future<SharedPreferences> sharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }

  Future<User>? get utilisateur {
    return sharedPreferences().then((value) => User(
        data: User.fromJson(json.decode("${value.getString("user")}")['Info'])
            .data));
  }*/
}
