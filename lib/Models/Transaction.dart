class Transaction {
  String? id,
      collecteur,
      client,
      montant,
      jour,
      statut,
      typeOperation,
      commission;
  Transaction(
      {this.client,
      this.commission,
      this.collecteur,
      this.id,
      this.jour,
      this.montant,
      this.statut,
      this.typeOperation});
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        client: json["client"],
        collecteur: json["collecteur"],
        commission: json["commission"],
        jour: json["jour"],
        statut: json["statut"],
        montant: json["montant"],
        typeOperation: json["typeOperation"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "collecteur": collecteur,
        "client": client,
        "montant": montant,
        "jour": jour,
        "statut": statut,
        "typeOperation": typeOperation,
        "commission": commission
      };
}
