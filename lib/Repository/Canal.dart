import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:mydirectcash/Models/BouquetCanal.dart';
import 'dart:convert';

import 'DioClient.dart';

class Canal extends ChangeNotifier {
  Future<List<BouquetCanal>> geBouquetCanal() async {
    Dio.Response response = await dio()
        .get("DirectcashOperations/PurchaseProduct/123456789/5258889");
    // print(response.toString());
    return _decodeBouquetCanal(response.data);
  }

  List<BouquetCanal> _decodeBouquetCanal(responseBody) {
    final parsed = responseBody;

    return parsed
        .map<BouquetCanal>((json) => BouquetCanal.fromJson(json))
        .toList();
  }
}
