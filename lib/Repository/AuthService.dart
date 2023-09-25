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
  bool _istel = false;
  User? get currentUser => _currentUser;
  String? solde;
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

        if (solde == null) {
          solde = _currentUser!.data!.solde!.toString();

          if (_currentUser!.data!.solde!.contains(".")) {
            solde =
                double.tryParse(_currentUser!.data!.solde!)!.toStringAsFixed(2);
          }
        }
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

  setconversion(int value) {
    switch (value) {
      case 0:
        solde = _currentUser!.data!.solde!.toString();

        if (_currentUser!.data!.solde!.contains(".")) {
          solde =
              double.tryParse(_currentUser!.data!.solde!)!.toStringAsFixed(2);
          notifyListeners();
        }

        break;
      case 1:
        String val =
            (double.tryParse(_currentUser!.data!.solde!)! / 600).toString();
        solde = (double.tryParse(_currentUser!.data!.solde!)! / 600).toString();
        if (val.contains(".")) {
          solde = double.tryParse(val)!.toStringAsFixed(2);
        }
        print(solde);
        notifyListeners();
        break;
      case 2:
        String val =
            (double.tryParse(_currentUser!.data!.solde!)! / 640).toString();
        solde = (double.tryParse(_currentUser!.data!.solde!)! / 640).toString();
        if (val.contains(".")) {
          solde = double.tryParse(val)!.toStringAsFixed(2);
          print(solde);
        }
        notifyListeners();
        break;
      default:
    }
    //notifyListeners();
  }

  bool get tel {
    sharedPreferences().then((value) {
      if (json.decode("${value.getString("tel")}") != null) {
        this._istel =
            json.decode("${value.getString("tel")}") != null ? true : false;
        //print(_isOpen);
        notifyListeners();
      }
    });
    return this._istel;
  }

  Future login(Map credentials) async {
    print(this._isLoggedIn);
    SharedPreferences pref = await SharedPreferences.getInstance();

    Dio.Response response =
        await dio().post("Authentication/Authenticate", data: credentials);
    // print(response.toString());
    print(response.data);
    if (json.decode(response.toString())['Message'] == "Success") {
      User user = User.fromJson(json.decode(response.toString())['Info']);
      await pref.setString("user", response.toString());
      await pref.setBool("open", true);
      await pref.setString("tel", user.data!.phone!);
      this._isLoggedIn = true;
      setconversion(0);
      notifyListeners();
    }

    print(json.decode(response.toString()));

    notifyListeners();
    return json.decode(response.toString())['Message'];
  }

  Future sendRaport(Map credentials) async {
    Dio.Response response =
        await dio().post("Collecteur/SendRequestSupport", data: credentials);
    return json.decode(response.toString());
  }

  Future loginWithBiometric(Map credentials) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Dio.Response response = await dio()
        .post("Authentication/AuthenticateWithFingerPrint", data: credentials);
    print(response.toString());
    if (json.decode(response.toString())['Message'] == "Success") {
      User user = User.fromJson(json.decode(response.toString())['Info']);
      bool a = authenticate;
      await pref.setString("user", response.toString());
      // await pref.setBool("open", true);

      notifyListeners();
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
    print(response.toString());
    print(json.decode(response.toString())["Message"]);

    return json.decode(response.toString())["Message"];
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

    return json.decode(response.toString())["message"];
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
    await pref.remove("open");
    await await pref.remove("tel");
    notifyListeners();
  }
  /*
  Swift Compiler Error (Xcode): No such module 'PPRiskMagnes'
/Users/willdewin/developement/mydirectcash/ios/Pods/Braintree
/Sources/PayPalDataCollector/Public/PayPalDataCollector/PPDat
aCollector.swift:0:7
  */
}
