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
      value,
      Photo,
      isVerified,
      pendingsolde,
      id;
  DataUser(
      {this.Photo,
      this.adresse,
      this.creerLe,
      this.email,
      this.matricule,
      this.nom,
      this.pass,
      this.phone,
      this.isVerified,
      this.pendingsolde,
      this.id,
      this.solde,
      this.statut,
      this.token,
      this.ville});
  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        id: json["id"],
        Photo: json["Photo"],
        adresse: json["Adresse"],
        creerLe: json["CreerLe"],
        email: json["Email"],
        matricule: json["Matricule"],
        nom: json["Nom"],
        pass: json["Pass"],
        isVerified: json["IsVerified"],
        pendingsolde: json["Pendingsolde"].toString(),
        phone: json["Phone"],
        // provider: json["provider"],
        // providerToken: json["providerToken"],
        solde: json["solde"].toString(),
        statut: json["Statut"],
        token: json["token"],
        ville: json["Ville"],
      );
  Map<String, dynamic> toJson() => {
        "nom": nom,
        "phone": phone,
        "matricule": matricule,
        "ville": ville,
        "adresse": adresse,
        "email": email,
        "solde": solde,
        "photo": Photo,
        "creerLe": creerLe,
        "pass": pass,
        "token": token,
        "statut": statut,
        "isVerified": isVerified,
        "pendingsolde": pendingsolde,
        // "provider": provider,
      };
}
