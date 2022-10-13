import 'package:flutter/material.dart';
import 'dart:convert';

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
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Simulateur_de_facture extends StatefulWidget {
  Simulateur_de_facture({Key? key}) : super(key: key);

  @override
  State<Simulateur_de_facture> createState() => _Simulateur_de_factureState();
}

class _Simulateur_de_factureState extends State<Simulateur_de_facture> {
  bool _isLoading = false;
  double? indice1 = 0, indice2 = 0;
  bool isfacture = false;
  dynamic fac = {"montTTC": "", "taxe": "", "consoKw": ""};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
                            "${AppLocalizations.of(context)!.translate("Simulation facture ENEO")}",
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
                    height: 50,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  indice1 =
                                      value == "" ? 0 : double.tryParse(value)!;
                                });
                              },
                              style: TextStyle(
                                  fontFamily: content_font, fontSize: 13),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      "${AppLocalizations.of(context)!.translate("Saisissez l ancien indice")}",
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
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  indice2 =
                                      value == "" ? 0 : double.tryParse(value)!;
                                });
                              },
                              style: TextStyle(
                                  fontFamily: content_font, fontSize: 13),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      "${AppLocalizations.of(context)!.translate("Saisissez le nouvel indice")}",
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
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: blueColor,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50)),
                              onPressed: () {
                                if (indice2! < indice1!) {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                          "${AppLocalizations.of(context)!.translate("le nouvel indice dois être supérieur à l ancien")}",
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  calcul(context, indice1, indice2)
                                      .then((value) {
                                    print(value);
                                    setState(() {
                                      _isLoading = false;
                                      isfacture = true;
                                      fac = value;
                                    });
                                  }).catchError((error) {
                                    setState(() {
                                      _isLoading = false;
                                      fac = {
                                        "montTTC": "",
                                        "taxe": "",
                                        "consoKw": ""
                                      };
                                    });
                                  });
                                }
                              },
                              child: Text(
                                "${AppLocalizations.of(context)!.translate("suivant")}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (isfacture)
                    Card(
                      elevation: 2,
                      child: Container(
                          padding: EdgeInsets.all(16),
                          height: 200,
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context)!.translate("Montant Estimatif")}",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 16, left: 16),
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: "XAF",
                                              style: TextStyle(
                                                  color: blueColor,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: " " +
                                                  fac["montTTC"]!.toString(),
                                              style: TextStyle(
                                                  color: blueColor,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold))
                                        ])),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                          "${AppLocalizations.of(context)!.translate(" Consomation ")}",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 16, left: 16),
                                        child: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: fac["consoKw"]!.toString(),
                                              style: TextStyle(
                                                  color: blueColor,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: " KW",
                                              style: TextStyle(
                                                  color: blueColor,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold))
                                        ])),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text(" TVA( 19,25 %) ",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 16, left: 16),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "XAF",
                                            style: TextStyle(
                                                color: blueColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: " " + fac["taxe"]!.toString(),
                                            style: TextStyle(
                                                color: blueColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold))
                                      ])),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          )),
                    )
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

  Future calcul(context, indice1, indice2) async {
    double consoKw = indice2 - indice1;
    double montTTC = 0;
    double taxe = 0;
    double _prixInf50 = 50;
    double _prixSup50 = 76;
    double _locationCompteur = 500;

    await Future.delayed(const Duration(seconds: 1), () {
      if (indice2 < indice1) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "le nouvel indice dois être supérieur à l ancien",
          ),
        );
      } else {
        if (consoKw < 50) {
          montTTC = consoKw * _prixInf50;
        } else {
          double montTHT = (consoKw * _prixSup50) + _locationCompteur;
          taxe = montTHT * 19.25 / 100;
          montTTC = montTHT + taxe;
        }
      }
    });
    return {"montTTC": montTTC, "taxe": taxe, "consoKw": consoKw};
  }
}
