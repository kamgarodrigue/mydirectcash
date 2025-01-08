import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_braintree/flutter_braintree.dart';

class Recharge_carte_credit_Token extends StatefulWidget {
  final List<dynamic> details;
  const Recharge_carte_credit_Token({Key? key, required this.details})
      : super(key: key);

  @override
  State<Recharge_carte_credit_Token> createState() =>
      _Recharge_carte_credit_TokenState();
}

class _Recharge_carte_credit_TokenState
    extends State<Recharge_carte_credit_Token> {
  bool _isLoading = false;
  bool _isOscure = true;
  String montant = "";

  void togle() {
    setState(() {
      _isOscure = !_isOscure;
      context.read<AuthService>().authenticate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthService>();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 40,
                          height: 50,
                          color: Colors.transparent,
                          child: Stack(children: [
                            Positioned(
                                top: 12,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: Settings()));
                                  },
                                  child: Image.asset(
                                    'assets/images/ico-parametre.png',
                                    width: 40,
                                  ),
                                ))
                          ]),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: blueColor,
                          ),
                        ),
                        const SizedBox(width: 50),
                        Text(
                            "${AppLocalizations.of(context)!.translate('Carte de crédit/Paypal1')}",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: title_font,
                                color: blueColor,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/logo-alliance-transparent.png',
                    ),
                  ),
                  /*
                  Container(
                    child: Column(
                      children: [
                        Text(
                            '${AppLocalizations.of(context)!.translate("Vous allez faire une recharge de")} ${widget.detail["amount"]} XAF ${AppLocalizations.of(context)!.translate("au numéro")} ${widget.dataTransaction!.toNumber!.substring(0, 3)} ** ** ${widget.dataTransaction!.toNumber!.substring(7, 9)}, ${AppLocalizations.of(context)!.translate("frais de")}  ${widget.detail["rate"]} XAF. ${AppLocalizations.of(context)!.translate("Montant total à débiter")}  ${widget.detail["totalAmount"]} XAF.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.5,
                                fontFamily: content_font,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ), */
                  DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text(
                          "${AppLocalizations.of(context)!.translate("Monais")}",
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "${AppLocalizations.of(context)!.translate("Amount")}",
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "${AppLocalizations.of(context)!.translate("Frais")}",
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      widget.details.length,
                      (index) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(widget.details[index]["currencyCode"])),
                          DataCell(SizedBox(
                            width: 80,
                            child: Text(widget.details[index]["convertedAmount"]
                                .toString()),
                          )),
                          DataCell(SizedBox(
                              width: 100,
                              child: Text(widget.details[index]["convertedFees"]
                                  .toString()))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(height: 50),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:  blueColor,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 50)),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                context
                                    .read<TransactonService>()
                                    .generateToken()
                                    .then((value) {
                                  var data = {
                                    "Price": widget.details[0]
                                        ["convertedAmount"],
                                    "PaymentMethodNonce": "",
                                    "Phone":
                                        authProvider.currentUser!.data!.phone,
                                    "Result": "",
                                    "TrxId": "",
                                    "PriceConverted": widget.details[0]
                                        ["convertedAmount"]
                                  };
                                  print("${"convertedAmount: " +
                                      int.tryParse(widget.details[1]
                                                  ["convertedAmount"]
                                              .toString())
                                          .toString() +
                                      " currencyCode " +
                                      widget.details[1]['currencyCode']} token: ${json
                                          .decode(value.toString())["code"]}");

                                /*  final request = BraintreePayPalRequest(
                                      amount: widget.details[1]
                                              ["convertedAmount"]
                                          .toString(),
                                      currencyCode: widget.details[1]
                                          ['currencyCode']);

                                  Braintree.requestPaypalNonce(
                                          json.decode(value.toString())["code"],
                                          request)
                                      .then((result) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (result != null) {
                                      print('Nonce: ${result.nonce}');
                                      data["PaymentMethodNonce"] = result.nonce;
                                      context
                                          .read<AuthService>()
                                          .loginWithBiometric({
                                        "id": context
                                            .read<AuthService>()
                                            .currentUser!
                                            .data!
                                            .phone
                                      });
                                    } else {
                                      print('PayPal flow was canceled.');
                                    }
                                  }).catchError((erro) {
                                    print(
                                        "Braintree Error: " + erro.toString());
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  });
*/
                                  //{currencyCode: EUR, convertedAmount: 78125.0, convertedFees: 3125.0}]
                                }).catchError((error) {
                                  print(error);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("suivant")!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Container(
                child: _isLoading
                    ? Loader(loadingTxt: 'Content is loading...')
                    : Container())
          ],
        ));
  }
}
