class User {
  DataUser? data;
  User({required this.data});
  factory User.fromJson(Map<String, dynamic> json) => User(
        data: DataUser.fromJson(json),
      );
  static User getUser(dynamic json) {
    return User(data: DataUser.fromJson(json));
  }

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class DataUser {
  String? matricule,
      nom,
      phone,
      ville,
      adresse,
      email,
      solde,
      creerLe,
      pass,
      token,
      statut,
      Photo,
      providerToken,
      id,
      provider;
  DataUser(
      {this.Photo,
      this.adresse,
      this.creerLe,
      this.email,
      this.matricule,
      this.nom,
      this.pass,
      this.phone,
      this.id,
      this.provider,
      this.providerToken,
      this.solde,
      this.statut,
      this.token,
      this.ville});
  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        //id: json["id"],
        Photo: json["photo"],
        adresse: json["adresse"],
        creerLe: json["creerLe"],
        email: json["email"],
        matricule: json["matricule"],
        nom: json["nom"],
        pass: json["pass"],
        phone: json["phone"],
        provider: json["provider"],
        providerToken: json["providerToken"],
        solde: json["solde"],
        statut: json["statu"],
        token: json["token"],
        ville: json["ville"],
      );
  Map<String, dynamic> toJson() => {
        "nom": id,
        "phone": phone,
        "ville": ville,
        "adresse": adresse,
        "email": email,
        "solde": solde,
        "photo": Photo,
        "creerLe": creerLe,
        "pass": pass,
        "token": token,
        "statut": statut,
        "providerToken": providerToken,
        "provider": provider,
      };
}
