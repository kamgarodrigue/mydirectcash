class Operateur {
  String? regionCodes, providerCode, providerName, validationRegex, urlImage;
  Operateur(
      {required this.providerCode,
      required this.providerName,
      required this.regionCodes,
      required this.urlImage,
      required this.validationRegex});
  factory Operateur.fromJson(Map<String, dynamic> json) => Operateur(
      providerCode: json["providerCode"],
      providerName: json["providerName"],
      regionCodes: json["regionCodes"],
      urlImage: json["urlImage"],
      validationRegex: json["validationRegex"]);
  Map<String, dynamic> toJson() => {
        "regionCodes": "DZ",
        "providerCode": "DJDZ",
        "providerName": "Djezzy Algeria",
        "validationRegex": "https://imagerepo.ding.com/logo/DJ/DZ.png",
        "urlImage": ""
      };
}
