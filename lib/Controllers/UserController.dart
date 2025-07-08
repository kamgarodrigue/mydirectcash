import 'dart:convert';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mydirectcash/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ControllerMVC {
  factory UserController() {
    _this ??= UserController._();
    return _this!;
  }

  static UserController? _this;

  UserController._();
  static UserController get userController => _this!;

  Future<SharedPreferences> sharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }

  Future<User>? get utilisateur {
    return sharedPreferences().then((value) => User(
        data: User.fromJson(json.decode("${value.getString("user")}")['Info'])
            .data));
  }
}
