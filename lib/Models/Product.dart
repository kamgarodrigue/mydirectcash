import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  String? urlImage,
      kuCode,
      displayName,
      maxReceiveValue,
      maxSendValue,
      receiveCurrencyIso;
  Product(
      {required this.displayName,
      required this.kuCode,
      required this.maxReceiveValue,
      required this.maxSendValue,
      required this.receiveCurrencyIso,
      required this.urlImage});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
      displayName: json["displayName"],
      kuCode: json["skuCode"],
      maxReceiveValue: json["maxReceiveValue"],
      maxSendValue: json["maxSendValue"],
      receiveCurrencyIso: json["receiveCurrencyIso"],
      urlImage: json["urlImage"] ?? "");

  Map<String, dynamic> toJson() => {
        "urlImage": "null",
        "skuCode": "AL_VF_TopUp_3.40",
        'displayName': "ALL 300.01",
        "maxReceiveValue": "300.01",
        "maxSendValue": "300.01",
        "receiveCurrencyIso": "ALL"
      };
}
