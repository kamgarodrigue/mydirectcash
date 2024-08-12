import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/DetailTransaction.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/envoi_comptedirectcash_password.dart';

import 'package:mydirectcash/screens/settings.dart';
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

  DataTransaction data = new DataTransaction(
    amount: "",
    cNI: "",
    fromNumber: "",
    id: "",
    pIN: "",
    pass: "",
    rate: "",
    toNumber: "",
  );
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
              padding: EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
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
                  SizedBox(
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
                        SizedBox(width: 20),
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/logo-alliance-transparent.png',
                    ),
                  ),
                  SizedBox(
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
                                      countryName = code!.name == null
                                          ? AppLocalizations.of(context)!.translate(
                                              "Choisissez le pays de destination")!
                                          : "${code.name} ($code)";
                                      codeRegion = code.code!;
                                    });
                                    print(code!.name);
                                  },
                                  useUiOverlay: true,
                                  useSafeArea: false),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(
                          height: 1.5,
                          color: blueColor,
                        ),
                      ],
                    ),
                  ),
                  // if (codeRegion == "CM")
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: data.toNumber,
                              onChanged: (value) {
                                setState(() {
                                  data.toNumber = value;
                                });
                              },
                              style: TextStyle(
                                  fontFamily: content_font, fontSize: 13),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)!
                                      .translate(
                                          "Saisissez le numéro bénéficiaire")!,
                                  hintStyle: TextStyle(
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
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: data.amount,
                              onChanged: (value) {
                                setState(() {
                                  data.amount = value;
                                });
                              },
                              style: TextStyle(
                                  fontFamily: content_font, fontSize: 13),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)!
                                      .translate("Saisire montant")!,
                                  hintStyle: TextStyle(
                                      fontFamily: content_font,
                                      color: Colors.grey,
                                      fontSize: 13))),
                          Divider(
                            height: 1.5,
                            color: blueColor,
                          ),
                        ],
                      )),
                  SizedBox(height: 50),
                  // if (codeRegion == "CM")
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
                                      EdgeInsets.symmetric(horizontal: 50)),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                data.fromNumber =
                                    autProvider.currentUser!.data!.phone;
                                // print(data.toJson());
                                context
                                    .read<TransactonService>()
                                    .getDetailEnvoiCompteDirectcash(
                                        data.toNumber, data.amount)
                                    .then((value) {
                                  data.rate =
                                      json.decode(value.toString())['rate'];
                                  data.id =
                                      autProvider.currentUser!.data!.phone;
                                  print(data.toJson());
                                  print(value);

                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: EnvoiCompteDirectCashPassword(
                                            data: data,
                                            context1: context,
                                            nom: json.decode(
                                                value.toString())['nom'],
                                            context2: widget.context2,
                                          )));
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
                                style: TextStyle(
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
