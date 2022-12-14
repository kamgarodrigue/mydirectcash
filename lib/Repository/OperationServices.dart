import 'dart:convert';
import 'package:dio/dio.dart' as Dio;

import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/Operateur.dart';
import 'package:mydirectcash/Models/Product.dart';
import 'package:mydirectcash/Repository/DioClient.dart';

class OperationServices extends ChangeNotifier {
  List _contry = [];
  List<Operateur> _operateurs = [];
  List<Product> _produits = [];
  List<dynamic> _tarifs = [];

  List get contry => _contry;
  List<Operateur> get operateurs => _operateurs;
  List<dynamic> get tarif => _tarifs;
  List<Product> get produits => _produits;
  Future getContry() async {
    Dio.Response response =
        await dio().get("DirectcashOperations/GetAllCountry");
    return response;
  }

  Future getOperatorsProduct(regionCode, providerCode) async {
    print("DirectcashOperations/GetOperatorProduct/$regionCode/$providerCode");

    Dio.Response response = await dio().get(
        "DirectcashOperations/GetOperatorProduct/$regionCode/$providerCode");
    return decodeProdoct(response.data);
  }

  Future<List<Operateur>> getContryOperator(regionCode) async {
    Dio.Response response =
        await dio().get("DirectcashOperations/GetCountryOperator/$regionCode");
    return decodeOperateur(response.data);
  }

  Future<List<dynamic>> getTarifs() async {
    Dio.Response response = await dio().get("DirectcashOperations/getFees");
    _tarifs =
        response.data["collecteFees"].map<dynamic>((json) => json).toList();
    ;
    notifyListeners();
    return response.data["collecteFees"].map<dynamic>((json) => json).toList();
  }

  List<Operateur> decodeOperateur(responseBody) {
    final parsed = responseBody;
    _operateurs =
        parsed.map<Operateur>((json) => Operateur.fromJson(json)).toList();
    notifyListeners();
    return parsed.map<Operateur>((json) => Operateur.fromJson(json)).toList();
  }

  List<Product> decodeProdoct(responseBody) {
    final parsed = responseBody;
    _produits = parsed.map<Product>((json) => Product.fromJson(json)).toList();
    notifyListeners();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}
