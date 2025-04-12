import 'package:flutter/material.dart';
import 'package:mydirectcash/app_localizations.dart';

class TransactionNew extends StatefulWidget {
  const TransactionNew({super.key});

  @override
  State<TransactionNew> createState() => _TransactionNewState();
}

class _TransactionNewState extends State<TransactionNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!
            .translate('Mes transactions')
            .toString()),
      ),
    );
  }
}
