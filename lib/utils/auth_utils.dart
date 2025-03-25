import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:provider/provider.dart';

Future reset(BuildContext context, Function setState) {
  context.read<AuthService>().authenticate;
  String? id = context.read<AuthService>().currentUser!.data!.phone;
  print(id);

  AuthService().loginWithBiometric(id).then((value) {
    setState(() {
      var solde = value["data"]["solde"].toString();
    });
  });

  return context.read<AuthService>().loginWithBiometric(id);
}
