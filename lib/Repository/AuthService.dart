import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/User.dart';
import 'package:mydirectcash/Repository/DioClient.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  Future<SharedPreferences> sharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }

  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isOpen = false;
  User? get currentUser => _currentUser;
  bool get authenticate {
    sharedPreferences().then((value) {
      if (json.decode("${value.getString("user")}") != null) {
        _currentUser = User.fromJson(
            json.decode("${value.getString("user")}")['Info'] ?? {});
        this._isLoggedIn = User.fromJson(
                        json.decode("${value.getString("user")}")['Info'] ?? {})
                    .data ==
                null
            ? false
            : true;
        notifyListeners();
      }
    });
    return this._isLoggedIn;
  }

  bool get isOpen {
    sharedPreferences().then((value) {
      if (json.decode("${value.getBool("open")}") != null) {
        this._isOpen = json.decode("${value.getBool("open")}");
        //print(_isOpen);
        notifyListeners();
      }
    });
    return this._isOpen;
  }

  Future login(Map credentials) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Dio.Response response =
        await dio().post("Authentication/Authenticate", data: credentials);
    print(response.toString());
    if (json.decode(response.toString())['Message'] == "Success") {
      User user = User.fromJson(json.decode(response.toString())['Info']);
      await pref.setString("user", response.toString());
      await pref.setBool("open", true);
    }

    print(json.decode(response.toString()));
    this._isLoggedIn = true;

    notifyListeners();
    return json.decode(response.toString())['Message'];
  }

/*
 User? userFrombd(User user) {
    return user.data == null ? null : User(data: user.data);
  }
  static Stream<User>  utilisateur {
    return auth.login(credentials).then(userFrombd);
  } */
  Future register(Map user) async {
    Dio.Response response =
        await dio().post("Authentication/Register", data: user);
    print(response.toString());
    print(json.decode(response.toString())["Message"]);
    this._isLoggedIn = true;
    notifyListeners();
    print(response);

    return json.decode(response.toString())["Message"];
  }

  Future resendCodeValidation(Map data) async {
    Dio.Response response =
        await dio().post("Authentication/SendRegistrationCode", data: data);
    // print(response.toString());
    // print(json.decode(response.toString())["Message"]);

    return response.data;
  }

  Future askResetPass(Map data) async {
    Dio.Response response =
        await dio().post("Authentication/AskResetPass", data: data);
    print(response.toString());
    // print(json.decode(response.toString())["Message"]);

    return response.data;
  }

  Future ResetPass(Map data) async {
    Dio.Response response =
        await dio().post("Authentication/ResetPass", data: data);
    print(response.toString());
    // print(json.decode(response.toString())["Message"]);

    return response.data;
  }

  Future validation(Map data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Dio.Response response =
        await dio().post("Authentication/verifiedAccount", data: data);
    print("test" + response.toString());

    notifyListeners();

    return json.decode(response.toString())["message"];
  }

  List<User> decodeFruit(responseBody) {
    final parsed = json.decode(responseBody)['response'];
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  Future<void> logout() async {
    this._isLoggedIn = false;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("user");
    await pref.setBool("open", false);
    notifyListeners();
  }
}
