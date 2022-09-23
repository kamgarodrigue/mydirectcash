class BouquetCanal {
  String? image, nomFormule, tarifFormule, paymentID;
  BouquetCanal(
      {this.image, this.nomFormule, this.paymentID, this.tarifFormule});
  factory BouquetCanal.fromJson(Map<String, dynamic> json) => BouquetCanal(
        //id: json["id"],
        image: 'assets/images/canal_plus.png',
        nomFormule: json["nomFormule"],
        paymentID: json["paymentID"],
        tarifFormule: json["tarifFormule"],
      );
  Map<String, dynamic> toJson() => {
        "nomFormule": nomFormule,
        "tarifFormule": tarifFormule,
        "paymentID": paymentID
      };
}
