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
        "urlImage": urlImage,
        "skuCode": kuCode,
        'displayName': displayName,
        "maxReceiveValue": maxReceiveValue,
        "maxSendValue": maxSendValue,
        "receiveCurrencyIso": receiveCurrencyIso
      };
}
