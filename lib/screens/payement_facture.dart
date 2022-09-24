import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/BouquetCanal.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/Canal.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/payement_facture_validate.dart';
import 'package:mydirectcash/screens/payement_marchant_montant.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PayementFacture extends StatefulWidget {
  PayementFacture({required this.factureInfos});
  dynamic factureInfos;
  //assets/images/ico-parametre.png

  @override
  _PayementFactureState createState() => _PayementFactureState();
}

class _PayementFactureState extends State<PayementFacture> {
  List<BouquetCanal> boquets = [];

  /* dynamic detailfacture = {
    "message": "Solde Insuffisant pour payer cette facture",
    "paymentID":
        "S-113-950-ENEO-10039-37848bf18e5e49a2b77d54247317cd5f-23bbb7e264c948f2beb077d452a44441",
    "amount": "2200.00",
    "numeroFacture": "585022237",
    "dateFacture": "12/06/2021 01:00:00",
    "dateEcheance": "12/16/2021 01:00:00",
    "penalite": "0.00"
  };*/

  @override
  void initState() {
    super.initState();
    Canal().geBouquetCanal().then((value) {
      setState(() {
        this.boquets = value;
      });
    });
    context.read<AuthService>().authenticate;
  }

  var data = {
    "amount": "",
    "paymentID": "",
    "adresseEmail": "",
    "numero": "",
    "serviceN": "",
    "pass": "",
    "imei": "5258889",
    "typeOp": "",
  };
  bool _isLoading = false;

  Widget bouquetContainer(int index) {
    final authService = context.watch<AuthService>();
    return GestureDetector(
      onTap: () {
        var data = {
          "amount": "${boquets[index].tarifFormule}",
          "paymentID": "",
          "adresseEmail": "",
          "numero": authService.currentUser!.data!.phone!,
          "serviceN": "",
          "pass": "",
          "imei": "5258889",
          "typeOp": 'canal',
        };
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: PayementFactureValidate(
                  factureInfos: {
                    'title': boquets[index].nomFormule,
                    'image': boquets[index].image,
                    'description': AppLocalizations.of(context)!
                        .translate('Choisissez le Bouquet de recharge')
                        .toString()
                  },
                  detailFac: data,
                )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "${boquets[index].image}",
              width: 50,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${boquets[index].nomFormule}",
                      style: TextStyle(
                          fontFamily: title_font,
                          color: blueColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "${boquets[index].tarifFormule}",
                      style: TextStyle(
                          fontFamily: content_font,
                          fontSize: 12,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                '1 mois',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: title_font,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic detailFac = {
    "typeOP": "",
    "id": "",
    "numeroDeContrat": "",
    "deviceId": "",
    "pass": "",
  };

  @override
  Widget build(BuildContext context) {
    detailFac["typeOP"] = widget.factureInfos["typeOP"];
    final authService = context.watch<AuthService>();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
              child: widget.factureInfos['title'] == 'Abonnement Canal+'
                  ? Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(horizontal: 25),
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
                                                    type: PageTransitionType
                                                        .rightToLeft,
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
                            padding: EdgeInsets.symmetric(horizontal: 25),
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
                                SizedBox(width: 50),
                                Text(
                                    AppLocalizations.of(context)!
                                        .translate('Payement de facture')
                                        .toString(),
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
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  widget.factureInfos['image'],
                                  width: 50,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.factureInfos['title'],
                                          style: TextStyle(
                                              fontFamily: title_font,
                                              color: blueColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          widget.factureInfos['description'],
                                          style: TextStyle(
                                              fontFamily: content_font,
                                              fontSize: 12,
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                  itemCount: boquets.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return boquets.isEmpty
                                        ? CircularProgressIndicator(
                                            color: blueColor,
                                          )
                                        : bouquetContainer(index);
                                  }),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.symmetric(horizontal: 25),
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
                                                  type: PageTransitionType
                                                      .rightToLeft,
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
                              SizedBox(width: 50),
                              Text(
                                  AppLocalizations.of(context)!
                                      .translate('Payement de facture')
                                      .toString(),
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
                          height: 30,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                widget.factureInfos['image'],
                                width: 50,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.factureInfos['title'],
                                        style: TextStyle(
                                            fontFamily: title_font,
                                            color: blueColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        widget.factureInfos['description'],
                                        style: TextStyle(
                                            fontFamily: content_font,
                                            fontSize: 12,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: detailFac["numeroDeContrat"],
                              onChanged: (value) {
                                setState(() {
                                  detailFac["numeroDeContrat"] = value;
                                });
                              },
                              style: TextStyle(
                                  fontFamily: content_font, fontSize: 13),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!
                                      .translate(
                                          'Saisissez votre numéro de contrat')
                                      .toString(),
                                  hintStyle: TextStyle(
                                      fontFamily: content_font,
                                      color: Colors.grey.shade500,
                                      fontSize: 13)),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50)),
                                    onPressed: () {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      context
                                          .read<TransactonService>()
                                          .getDetailFactureEneoCamwater(
                                            widget.factureInfos["typeOP"],
                                            authService
                                                .currentUser!.data!.phone!,
                                            detailFac["numeroDeContrat"],
                                          )
                                          .then((value) {
                                        List<dynamic> details = [];
                                        final det = value.data;
                                        details =
                                            det.map((json) => json).toList();
                                        print(details);
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        if (details.isNotEmpty) {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child:
                                                      PayementFactureValidate(
                                                    factureInfos:
                                                        widget.factureInfos,
                                                    detailFac: details[0],
                                                  )));
                                        }
                                      }).catchError((error) {
                                        print(error);
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('suivant')
                                          .toString(),
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
