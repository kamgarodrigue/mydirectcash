import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/DetailTransaction.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/envoi_comptedirectcash_password.dart';

import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EnvoiCompteDirectCash extends StatefulWidget {
  dynamic context2;
  EnvoiCompteDirectCash({Key? key, this.context2}) : super(key: key);

  @override
  _EnvoiCompteDirectCashState createState() => _EnvoiCompteDirectCashState();
}

class _EnvoiCompteDirectCashState extends State<EnvoiCompteDirectCash> {
  String? countryName = '';
  String? operateur = "Choisissez l'opérateur";

  // DataTransaction data = DataTransaction(
  //   amount: "",
  //   cNI: "",
  //   fromNumber: "",
  //   id: "",
  //   pIN: "",
  //   pass: "",
  //   rate: "",
  //   toNumber: "",
  // );

  Map data = {
    "vClientID": "",
    "vAmount": "",
    "vRate": 0.0,
    "vFromNumber": "",
    "vToNumber": "",
    "vCNI": " ",
    "vPIN": "",
    "vrxtype": "",
  };
  Map? param;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AuthService>().authenticate;
  }

  String codeRegion = "";

  @override
  Widget build(BuildContext context) {
    final autProvider = context.watch<AuthService>();

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
                        const SizedBox(width: 20),
                        Text(
                            AppLocalizations.of(context)!
                                .translate("Envoi - Compte MyDirectCash")!,
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/logo-alliance-transparent.png',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                    countryName == ''
                                        ? AppLocalizations.of(context)!.translate(
                                            "Choisissez le pays de destination")!
                                        : countryName!,
                                    style: TextStyle(
                                        color: countryName == ''
                                            ? Colors.grey
                                            : Colors.black,
                                        fontSize: 14)),
                              ),
                              CountryListPick(
                                  appBar: AppBar(
                                    backgroundColor: blueColor,
                                    title: Text(AppLocalizations.of(context)!
                                        .translate(
                                            "Choisissez le pays de destination")!),
                                  ),
                                  theme: CountryTheme(
                                    isShowFlag: false,
                                    isShowTitle: false,
                                    isShowCode: false,
                                    isDownIcon: true,
                                    showEnglishName: false,
                                  ),
                                  initialSelection: '+237',
                                  onChanged: (CountryCode? code) {
                                    setState(() {
                                      code.toString() == "+237"
                                          ? data["vrxtype"] = "11"
                                          : data["vrxtype"] = "12";
                                      countryName = code!.name == null
                                          ? AppLocalizations.of(context)!.translate(
                                              "Choisissez le pays de destination")!
                                          : "${code.name} ($code)";
                                      codeRegion = code.code!;
                                    });
                                  },
                                  useUiOverlay: true,
                                  useSafeArea: false),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          height: 1.5,
                          color: blueColor,
                        ),
                      ],
                    ),
                  ),
                  // if (codeRegion == "CM")
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.number,
                              // initialValue: data.toNumber,
                              onChanged: (value) {
                                setState(() {
                                  data["vToNumber"] = value;
                                });
                              },
                              style: const TextStyle(
                                  fontFamily: content_font, fontSize: 13),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)!
                                      .translate(
                                          "Saisissez le numéro bénéficiaire")!,
                                  hintStyle: const TextStyle(
                                      fontFamily: content_font,
                                      color: Colors.grey,
                                      fontSize: 13))),
                          Divider(
                            height: 1.5,
                            color: blueColor,
                          ),
                        ],
                      )),
                  //  if (codeRegion == "CM")
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.number,
                              // initialValue: data.amount,
                              onChanged: (value) {
                                setState(() {
                                  data['vAmount'] = value;
                                });
                              },
                              style: const TextStyle(
                                  fontFamily: content_font, fontSize: 13),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)!
                                      .translate("Saisire montant")!,
                                  hintStyle: const TextStyle(
                                      fontFamily: content_font,
                                      color: Colors.grey,
                                      fontSize: 13))),
                          Divider(
                            height: 1.5,
                            color: blueColor,
                          ),
                        ],
                      )),
                  const SizedBox(height: 50),
                  // if (codeRegion == "CM")
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: blueColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50)),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                  param = {
                                    "amount": data['vAmount'],
                                    "to": data['vToNumber'],
                                    "transactionType": data['vrxtype'],
                                  };
                                });
                                TransactonService()
                                    .getDetailEnvoiDirectcash(param)
                                    .then((value) {
                                  data['vFromNumber'] =
                                      autProvider.currentUser!.data!.phone;
                                  data["vClientID"] =
                                      autProvider.currentUser!.data!.phone;
                                  data["vRate"] = value["data"]["fees"];
                                  if (value['data']['nameReceiver']
                                          .toString()
                                          .length <
                                      4) {
                                    DialogWidget.success(context,
                                        title: "",
                                        content: "Le compte n'existe pas!",
                                        color: blueColor, callback: () {
                                      Navigator.pop(context);
                                    });
                                  } else if (data['vToNumber'] ==
                                      data['vFromNumber']) {
                                    DialogWidget.success(context,
                                        title: "Transaction impossible!",
                                        content:
                                            "veuillez saissir un autre numéro de téléphone",
                                        color: blueColor, callback: () {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child:
                                                EnvoiCompteDirectCashPassword(
                                              data: data,
                                              context1: context,
                                              nom: value['data']
                                                  ['nameReceiver'],
                                              context2: widget.context2,
                                            )));
                                  }

                                  setState(() {
                                    _isLoading = false;
                                  });
                                }).catchError((error) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                                /* */
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
