import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/DetailTransaction.dart';
import 'package:mydirectcash/Models/Transaction.dart';
import 'package:mydirectcash/Repository/DioClient.dart';
import 'dart:convert';

class TransactonService extends ChangeNotifier {
  List<Transaction> _historiques = [];
  List<Transaction> get historique => _historiques;
  Future transfertByDirectcash(Map? data) async {
    print(data);
    print("===============================================================");
    Dio.Response response =
        await dio().post("https://apibackoffice.alliancefinancialsa.com/envoiDirectcash", data: data);
    return response.data;
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

  Future EnvoiCompteDirectcash(DataTransaction data, nom) async {
    Dio.Response response =
        await dio().post("Collecteur/TransfertMoney", data: {
      "receiver": data.toNumber,
      "idsender": data.fromNumber,
      "montant": data.amount,
      "pass": data.pass,
      "isClient": nom == "" ? 0 : 1
    });
    return response;
  }

  Future getDetailEnvoiDirectcash(Map? data) async {
    print(data);

    Dio.Response response = await dio().post(
        "https://apibackoffice.alliancefinancialsa.com/getRateMD",
        data: data);
    print(response.data);
    return response.data;
  }

  Future getDetailFactureEneoCamwater(typeOp, id, numerodecontrat) async {
    print("DirectcashOperations/BillDetailled/$typeOp/$id/$numerodecontrat");
    Dio.Response response = await dio()
        .get("DirectcashOperations/BillDetailled/$typeOp/$id/$numerodecontrat");
    print(response.data);
    return response.data;
  }

  Future<List<Transaction>> getHistory(String number) async {
    Dio.Response response = await dio().get(
        "https://apibackoffice.alliancefinancialsa.com/Transactions/Historiques/LastFive/$number");
    print(response.data);

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
    print(response.data);
    return response.data;
  }

  Future achatCreditInternational(Map? data) async {
    Dio.Response response = await dio()
        .post("DirectcashOperations/AirtimeInternational", data: data);
    print(response.data);
    return response.data;
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
    Map data = {
      "pin": codeSecret,
      "pass": psw,
      "directcode": directCashCode,
      "id": id
    };
    print(data.toString());
    Dio.Response response =
        await dio().post("Collecteur/CreditFromDirectCash", data: data);
    return json.decode(response.toString());
  }

  Future payerMarchant(Map? data) async {
    print(data);
    Dio.Response response = await dio().post(
        "https://apibackoffice.alliancefinancialsa.com/Colecte_And_PaymentMarchant_MD",
        data: data);
    print(response.data);
    return response.data;
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
