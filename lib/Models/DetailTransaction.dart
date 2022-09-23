class DetailTransaction {
  DataTransaction? data;
  DetailTransaction({required this.data});
  factory DetailTransaction.fromJson(Map<String, dynamic> json) =>
      DetailTransaction(
        data: DataTransaction.fromJson(json),
      );
  static DetailTransaction getUser(dynamic json) {
    return DetailTransaction(data: DataTransaction.fromJson(json));
  }

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class DataTransaction {
  String? amount, fromNumber, toNumber, cNI, pIN, rate, id, pass;
  DataTransaction(
      {this.amount,
      this.fromNumber,
      this.cNI,
      this.id,
      this.pIN,
      this.pass,
      this.rate,
      this.toNumber});
  factory DataTransaction.fromJson(Map<String, dynamic> json) =>
      DataTransaction(
        id: json["Id"],
        amount: json["Amount"],
        cNI: json["CNI"],
        fromNumber: json["FromNumber"],
        pIN: json["PIN"],
        pass: json["Pass"],
        rate: json["Rate"],
        toNumber: json["ToNumber"],
      );
  Map<String, dynamic> toJson() => {
        "Amount": amount,
        "FromNumber": fromNumber,
        "ToNumber": toNumber,
        "CNI": cNI,
        "PIN": pIN,
        "Rate": rate,
        "Id": id,
        "Pass": pass
      };
}
