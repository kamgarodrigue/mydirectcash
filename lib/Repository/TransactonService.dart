import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/Transaction.dart';
import 'package:mydirectcash/Models/User.dart';
import 'package:mydirectcash/Repository/DioClient.dart';
import 'package:mydirectcash/screens/payement_facture.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TransactonService extends ChangeNotifier {
  List<Transaction> _historiques = [];
  List<Transaction> get historique => _historiques;
  Future transfertByDirectcash(Map data) async {
    Dio.Response response =
        await dio().post("DirectcashOperations/Sendmoney", data: data);
    return json.decode(response.toString());
  }

  Future PayementFactureCamwaterEneo(id, device, data) async {
    Dio.Response response = await dio()
        .post("DirectcashOperations/EndPayment/$id/$device", data: data);
    return json.decode(response.toString());
  }

  Future getDetailEnvoiCompteDirectcash(phoneNumber, amount) async {
    Dio.Response response =
        await dio().get("Collecteur/ClientDetails/$phoneNumber/$amount");
    return response;
  }

  Future getDetailEnvoiDirectcash(id, amount) async {
    Dio.Response response =
        await dio().get("DirectcashOperations/Detailled/$id/$amount");
    return response;
  }

  Future getDetailFactureEneoCamwater(typeOp, id, numerodecontrat) async {
    Dio.Response response = await dio()
        .get("DirectcashOperations/BillDetailled/$typeOp/$id/$numerodecontrat");
    return response;
  }

  Future<List<Transaction>> getHistory(String number) async {
    Dio.Response response =
        await dio().get("Transactions/Historiques/LastFive/$number");
    print(
        "http://172.107.60.78:3000/api/Transactions/Historiques/LastFive/$number");
    print(response);
    return decodeTransaction(response.data);
  }

  List<Transaction> decodeTransaction(responseBody) {
    final parsed = responseBody;
    _historiques =
        parsed.map<Transaction>((json) => Transaction.fromJson(json)).toList();
    notifyListeners();
    return parsed
        .map<Transaction>((json) => Transaction.fromJson(json))
        .toList();
  }

  Future achatCredit(Map? data) async {
    Dio.Response response =
        await dio().post("DirectcashOperations/Airtime", data: data);
    return json.decode(response.toString());
  }

  Future getTopupDetails(amount) async {
    Dio.Response response =
        await dio().get("DirectcashOperations/getTopupDetails/$amount");
    return response;
  }

  Future checkout(Map? data) async {
    Dio.Response response =
        await dio().post("BraintreeOperations/Checkout", data: data);
    return response;
  }

  Future generateToken() async {
    Dio.Response response =
        await dio().get("BraintreeOperations/GenerateToken");
    return response;
  }

  Future creditFromDirectcash(directCashCode, codeSecret, psw, id) async {
    Map data = {"pin": codeSecret, "pass": psw, "directcode": psw, "id": id};
    Dio.Response response =
        await dio().post("DirectcashOperations/Airtime", data: data);
    return json.decode(response.toString());
  }

  Future payerMarchant(Map? data) async {
    Dio.Response response =
        await dio().post("DirectcashOperations/Airtime", data: data);
    return json.decode(response.toString());
  }

  Future depotMomo(Map? data) async {
    print("${data!["Id"]}");
    Dio.Response response =
        await dio().post("DirectcashOperations/Retrait", data: data);
    return json.decode(response.toString());
  }

  Future retraitMomo(Map? data) async {
    Dio.Response response =
        await dio().post("DirectcashOperations/Retrait", data: data);
    return json.decode(response.toString());
  }

  Future sendMoneyDirectCash(Map? data) async {
    Dio.Response response =
        await dio().post("DirectcashOperations/Sendmoney", data: data);
    return json.decode(response.toString());
  }
}
