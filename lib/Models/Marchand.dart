class Marchand {
  String? agentId, agentName, phone, email, company, agentType, nomContact;
  Marchand({
    this.agentId,
    this.agentName,
    this.phone,
    this.email,
    this.company,
    this.agentType,
    this.nomContact,
  });
  factory Marchand.fromJson(Map<String, dynamic> json) => Marchand(
        agentId: json["Agent_ID"],
        agentName: json["AgentName"],
        phone: json["Phone"],
        email: json["Email"],
        company: json["Company"],
        agentType: json["AgentType"].toString(),
        nomContact: json["nomContact"],
      );
  Map<String, dynamic> toJson() => {
        "agentId": agentId,
        "agentName": agentName,
        "phone": phone,
        "email": email,
        "company": company,
        "agentType": agentType,
        "nomContact": nomContact
      };
}
