import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydirectcash/Models/User.dart';
import 'package:mydirectcash/Repository/DioClient.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  Future<SharedPreferences> sharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }

  User? _currentUser = User(data: DataUser(solde: "0", matricule: ""));

  bool _isLoggedIn = false;
  bool _isOpen = false;
  bool _istel = false;
  User? get currentUser => _currentUser;
  String? solde;
  String? pendingsolde;
  bool get authenticate {
    //logout()
    sharedPreferences().then((value) {
      _currentUser = User.fromJson(jsonDecode(value.getString("user") ?? '{}'));
      _isLoggedIn = _currentUser?.data?.statut == null ? false : true;
      solde = _currentUser?.data!.solde.toString();
      pendingsolde = _currentUser?.data!.pendingsolde.toString();
      if (_currentUser!.data!.solde!.contains(".")) {
        solde = double.tryParse(_currentUser!.data!.solde!)!.toStringAsFixed(2);
      }

      notifyListeners();
    });
    return _isLoggedIn;
  }

  bool get isOpen {
    sharedPreferences().then((value) {
      if (json.decode("${value.getBool("open")}") != null) {
        _isOpen = json.decode("${value.getBool("open")}");
        //print(_isOpen);
        notifyListeners();
      }
    });
    return _isOpen;
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
        _istel =
            json.decode("${value.getString("tel")}") != null ? true : false;
        //print(_isOpen);
        notifyListeners();
      }
    });
    return _istel;
  }

  // Future login(Map credentials) async {
  //   print(_isLoggedIn);
  //   SharedPreferences pref = await SharedPreferences.getInstance();

  //   Dio.Response response =
  //       await dio().post("Authentication/Authenticate", data: credentials);
  //   // print(response.toString());
  //   print(response.data);
  //   if (json.decode(response.toString())['Message'] == "Success") {
  //     User user = User.fromJson(json.decode(response.toString())['Info']);
  //     await pref.setString("user", response.toString());
  //     await pref.setBool("open", true);
  //     await pref.setString("tel", user.data!.phone!);
  //     _isLoggedIn = true;
  //     setconversion(0);
  //     notifyListeners();
  //   }

  //   print(json.decode(response.toString()));

  //   notifyListeners();
  //   return json.decode(response.toString())['Message'];
  // }
  Future login(Map credentials) async {
    print(
        "================================== credentials ============================================");
    print(credentials);
    SharedPreferences pref = await SharedPreferences.getInstance();
    Dio.Response response = await dio().post(
        "https://apibackoffice.alliancefinancialsa.com/login",
        data: credentials);

    print(response.data);

    if (response.data["message"] == "Authentification réussie.") {
      User user = User.fromJson(response.data['info']);
      await pref.setString("user", jsonEncode(response.data['info']));
      await pref.setBool("open", true);
      await pref.setString("tel", user.data!.phone!);
      _isLoggedIn = true;
      setconversion(0);
      // notifyListeners();
    }

    notifyListeners();
    return response.data['message'];
  }

  Future sendRaport(Map credentials) async {
    Dio.Response response =
        await dio().post("Collecteur/SendRequestSupport", data: credentials);
    return json.decode(response.toString());
  }

  Future loginWithBiometric(id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Dio.Response response = await dio().get(
        "https://apibackoffice.alliancefinancialsa.com/login-fingerprint?id=$id");
    print(response.data['data']['solde']);
    User user = User.getUser(response.data['data']);
    print(user.data?.toJson());
    await pref.setString("solde", user.data!.solde!);

    // _isLoggedIn = true;

    notifyListeners();
    return response.data;
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
    // print(response.toString());
    // print(json.decode(response.toString())["Message"]);
    _isLoggedIn = true;
    notifyListeners();
    return json.decode(response.toString());
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
    print(data);
    Dio.Response response =
        await dio().post("Authentication/verifiedAccount", data: data);
    print("test$response");

    notifyListeners();

    return json.decode(response.toString())["message"];
  }

  List<User> decodeFruit(responseBody) {
    final parsed = json.decode(responseBody)['response'];
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  Future<void> logout() async {
    _isLoggedIn = false;

    solde = "0";
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("user");

    await pref.remove("tel");
    notifyListeners();
  }
  /*
  Swift Compiler Error (Xcode): No such module 'PPRiskMagnes'
/Users/willdewin/developement/mydirectcash/ios/Pods/Braintree
/Sources/PayPalDataCollector/Public/PayPalDataCollector/PPDat
aCollector.swift:0:7
  */

  Future<dynamic> registerWithKyc(
      {required String vnomClient,
      required String vphone,
      required String vpays,
      required String vadresse,
      required String vurlphoto,
      required String vdeviceId,
      required String vemail,
      required String vpass,
      required String p_identiteNo,
      required String p_NUI,
      required String p_Profession,
      required String p_cniNo,
      required String p_dateValidationCNI,
      required String p_RegistreCom,
      required String p_Datenaissance,
      required String p_CNIContact,
      required String p_phoneContact,
      required String p_nomContact,
      String? p_cniRectoPath,
      String? p_cniVersoPath,
      String? p_passportPath,
      String? p_photoPath,
      required String Ville,
      required String p_sexe,
      required String code}) async {
    final formData = Dio.FormData();

    // Ajouter les champs texte
    formData.fields.addAll([
      MapEntry('vnomClient', vnomClient),
      MapEntry('vphone', vphone),
      MapEntry('vpays', vpays),
      MapEntry('vadresse', vadresse),
      MapEntry('vurlphoto', vurlphoto),
      MapEntry('vdeviceId', vdeviceId),
      MapEntry('vemail', vemail),
      MapEntry('vpass', vpass),
      MapEntry('p_identiteNo', p_identiteNo),
      MapEntry('p_NUI', p_NUI),
      MapEntry('p_Profession', p_Profession),
      MapEntry('p_cniNo', p_cniNo),
      MapEntry('p_dateValidationCNI', p_dateValidationCNI),
      MapEntry('p_RegistreCom', p_RegistreCom),
      MapEntry('p_Datenaissance', p_Datenaissance),
      MapEntry('p_CNIContact', p_CNIContact),
      MapEntry('p_phoneContact', p_phoneContact),
      MapEntry('p_nomContact', p_nomContact),
      MapEntry('Ville', Ville),
      MapEntry('p_sexe', p_sexe),
      MapEntry('code', code)
    ]);

// Créer une liste de fichiers à ajouter au formData
    List<MapEntry<String, Dio.MultipartFile>> files = [];

// Vérifiez et ajoutez chaque fichier s'il existe
    if (p_cniRectoPath != null && p_cniRectoPath.isNotEmpty) {
      files.add(MapEntry(
        'p_cniRecto',
        await Dio.MultipartFile.fromFile(p_cniRectoPath,
            filename: 'cni_recto.jpg'),
      ));
    }

    if (p_cniVersoPath != null && p_cniVersoPath.isNotEmpty) {
      files.add(MapEntry(
        'p_cniVerso',
        await Dio.MultipartFile.fromFile(p_cniVersoPath,
            filename: 'cni_verso.jpg'),
      ));
    }

    if (p_passportPath != null && p_passportPath.isNotEmpty) {
      files.add(MapEntry(
        'p_passport',
        await Dio.MultipartFile.fromFile(p_passportPath,
            filename: 'passport.jpg'),
      ));
    }

    if (p_photoPath != null && p_photoPath.isNotEmpty) {
      files.add(MapEntry(
        'p_photo',
        await Dio.MultipartFile.fromFile(p_photoPath, filename: 'photo.jpg'),
      ));
    }

// Ajouter les fichiers valides au formData
    formData.files.addAll(files);

    try {
      final response = await dio().post(
        'https://apibackoffice.alliancefinancialsa.com/registerWithKyc', // Remplacez par votre URL d'API
        data: formData,
        options: Dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response.data;
    } catch (e) {
      print('Erreur: $e');
      return 'Erreur: $e';
    }
  }
}
