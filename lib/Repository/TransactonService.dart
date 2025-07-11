import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/Transaction.dart';
import 'package:mydirectcash/Repository/DioClient.dart';
import 'dart:convert';

class TransactonService extends ChangeNotifier {
  List<Transaction> _historiques = [];
  List<Transaction> get historique => _historiques;

  Future transfertByDirectcash(Map? data) async {
    Dio.Response response = await dio().post(
        "https://apibackoffice.alliancefinancialsa.com/envoiDirectcash",
        data: data);
    return response.data;
  }

  Future payBill(Map? data) async {
    Dio.Response response = await dio().post(
        "https://apibackoffice.alliancefinancialsa.com/payBill",
        data: data);
    return response.data;
  }

  Future retraitDirectcash(Map? data) async {
    print(data);
    Dio.Response response = await dio().post(
        "https://apibackoffice.alliancefinancialsa.com/retraitDirectcash",
        data: data);
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

  Future EnvoiCompteDirectcash(Map? data) async {
    Dio.Response response = await dio().post(
      "https://apibackoffice.alliancefinancialsa.com/clientToclient",
      data: data,
    );
    return response.data;
  }

  Future getDetailEnvoiDirectcash(Map? data) async {
    Dio.Response response = await dio().post(
      "https://apibackoffice.alliancefinancialsa.com/getRateMD",
      data: data,
    );
    return response.data;
  }

  Future getDetailFactureEneoCamwater(
      typeOp, numerodecontrat, userId, idtrasaction) async {
    print(idtrasaction);
    Dio.Response response = await dio().get(
        "https://apibackoffice.alliancefinancialsa.com/bill_detailed/$numerodecontrat/$typeOp/$idtrasaction/$userId");
    print(response.data);
    return response.data;
  }

  Future getHistory(Map? data) async {
    Dio.Response response = await dio().post(
        "https://apibackoffice.alliancefinancialsa.com/HystoriqueTransaction",
        data: data);

    return response.data;
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
    Dio.Response response = await dio().post(
        "https://apibackoffice.alliancefinancialsa.com/cashin_topup",
        data: data);
    return response.data;
  }

  Future achatCreditInternational(Map? data) async {
    Dio.Response response = await dio()
        .post("DirectcashOperations/AirtimeInternational", data: data);
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

  Future getTransferDetails(Map? data) async {
    print(data);
    Dio.Response response = await dio().post(
        "https://apibackoffice.alliancefinancialsa.com/getTransferDetails",
        data: data);
    return response.data;
  }

  Future creditFromDirectcash(directCashCode, codeSecret, psw, id) async {
    Map data = {
      "pin": codeSecret,
      "pass": psw,
      "directcode": directCashCode,
      "id": id
    };
    Dio.Response response = await dio()
        .post("https://apibackoffice.alliancefinancialsa.com", data: data);
    return json.decode(response.toString());
  }

  Future payerMarchant(Map? data) async {
    Dio.Response response = await dio().post(
        "https://apibackoffice.alliancefinancialsa.com/Colecte_And_PaymentMarchant_MD",
        data: data);
    return response.data;
  }

  Future depotMomo(Map? data) async {
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
