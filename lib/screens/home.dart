import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mydirectcash/AppLanguage.dart';
import 'package:mydirectcash/Controllers/UserController.dart';
import 'package:mydirectcash/Models/Transaction.dart';
import 'package:mydirectcash/Models/User.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/Repository/localisation.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/achat_credit.dart';
import 'package:mydirectcash/screens/carousel_page.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/om_momo.dart';
import 'package:mydirectcash/screens/payement_marchand.dart';
import 'package:mydirectcash/screens/recharge_directcash.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/bottom_navigation.dart';
import 'package:mydirectcash/widgets/choix_envoi_argent.dart';
import 'package:mydirectcash/widgets/choix_facture_component.dart';
import 'package:mydirectcash/widgets/choix_recharge.dart';
import 'package:mydirectcash/widgets/last_transactions.dart';
import 'package:mydirectcash/widgets/success_operation_component.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showDollar = true;
  int conversion = 0;
  void setconversion(int value) {
    if (solde != 0) {
      switch (value) {
        case 0:
          context.read<AuthService>().setconversion(value);

          conversion = value;

          break;
        case 1:
          context.read<AuthService>().setconversion(value);

          conversion = value;

          break;
        case 2:
          context.read<AuthService>().setconversion(value);
          conversion = value;

          break;
        case 3:
          conversion = value;

          break;
        default:
      }
    }
  }

  String solde = "0";
  @override
  void initState() {
    super.initState();
    context.read<AuthService>().authenticate;
    //context.read<AuthService>().setconversion(0);
    context.read<Localisation>().initLocation();
  }

  Future reset() {
    context.read<AuthService>().loginWithBiometric(
        {"id": context.read<AuthService>().currentUser!.data!.phone});
    context.read<TransactonService>().getHistory(
        context.read<AuthService>().currentUser!.data!.phone.toString());
    return context.read<TransactonService>().getHistory(
        context.read<AuthService>().currentUser!.data!.phone.toString());
  }

  @override
  Widget build(BuildContext context) {
    AuthService autProvider = context.watch<AuthService>();

    List<dynamic> list = [
      {
        "title": AppLocalizations.of(context)!.translate('Achat de crédit'),
        "image": Image.asset(
          'assets/images/ico-achat-credit.png',
          color: blueColor,
          width: 50,
        ),
        "onTap": () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: AchatCredit()));
        }
      },
      {
        "title": AppLocalizations.of(context)!.translate('Payement Marchand'),
        "image": Image.asset(
          'assets/images/ico-paiement-marchand.png',
          color: blueColor,
          width: 50,
        ),
        "onTap": () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: PayementMarchand()));
        }
      },
      {
        "title": AppLocalizations.of(context)!.translate('Envoi d\'argent'),
        "image": Image.asset(
          'assets/images/ico-transfert-dargent.png',
          color: blueColor,
          width: 50,
        ),
        "onTap": () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return ChoixEnvoiArgent();
              });
        }
      },
      {
        "title": AppLocalizations.of(context)!.translate('Payement de facture'),
        "image": Image.asset(
          'assets/images/ico-facture.png',
          color: blueColor,
          width: 50,
        ),
        "onTap": () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return ChoixFacture();
              });
        },
      },
      {
        "title": AppLocalizations.of(context)!.translate('title7'),
        "image": Image.asset(
          'assets/images/bank-solid-24.png',
          color: blueColor,
          width: 50,
        ),
        "onTap": () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return ChoixFacture();
              });
        },
      },
    ];
    void gridNavigation(index) {
      switch (index) {
        case 0:
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: AchatCredit()));

          break;
        case 1:
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: PayementMarchand()));

          break;
        case 2:
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return ChoixEnvoiArgent();
              });
          break;
        case 3:
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return ChoixFacture();
              });
          break;
        case 5:
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: OmMoMo()));
          break;
        default:
      }
    }

    return Consumer<AuthService>(builder: (context, open, child) {
      if (open.isOpen) {
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: RefreshIndicator(
              onRefresh: () => reset(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      width: 100,
                                      height: 100,
                                      child: Image.asset(
                                        'assets/images/logo-alliance-transparent.png',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 70,
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            autProvider.currentUser!.data!.nom
                                                .toString(),
                                            style: TextStyle(
                                                color: blueColor,
                                                fontSize: 14,
                                                fontFamily: title_font),
                                          ),
                                          Text(
                                            autProvider.currentUser!.data!.phone
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: content_font),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 100,
                                color: Colors.transparent,
                                child: Stack(children: [
                                  Positioned(
                                      top: 30,
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
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: blueColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50)),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ChoixRecharge();
                                          });
                                    },
                                    child: Text(
                                      "${AppLocalizations.of(context)!.translate('Recharger mon compte')}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: content_font),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: blueColor,
                            child: Icon(
                              Icons.priority_high,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            AppLocalizations.of(context)!
                                .translate("notification")!,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: blueColor),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Card(
                          child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.translate('Solde courant')}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: content_font),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            context
                                                .read<AuthService>()
                                                .solde
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 34,
                                                fontFamily: title_font),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setconversion(0);
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        conversion == 0
                                                            ? blueColor
                                                            : Colors.grey,
                                                    radius: 20,
                                                    child: CircleAvatar(
                                                        radius: 19,
                                                        backgroundColor:
                                                            conversion == 0
                                                                ? Colors.white
                                                                : Colors.grey,
                                                        child: Text(
                                                          "XAF",
                                                          style: TextStyle(
                                                              color: conversion ==
                                                                      0
                                                                  ? blueColor
                                                                  : Colors
                                                                      .white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                GestureDetector(
                                                  onTap: () {
                                                    setconversion(1);
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        conversion == 1
                                                            ? blueColor
                                                            : Colors.grey,
                                                    radius: 20,
                                                    child: CircleAvatar(
                                                        radius: 19,
                                                        backgroundColor:
                                                            conversion == 1
                                                                ? Colors.white
                                                                : Colors.grey,
                                                        child: Icon(
                                                          Icons.attach_money,
                                                          color: conversion == 1
                                                              ? blueColor
                                                              : Colors.white,
                                                          size: 20,
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                GestureDetector(
                                                  onTap: () {
                                                    setconversion(2);
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        conversion == 2
                                                            ? blueColor
                                                            : Colors.grey,
                                                    radius: 20,
                                                    child: CircleAvatar(
                                                        radius: 19,
                                                        backgroundColor:
                                                            conversion == 2
                                                                ? Colors.white
                                                                : Colors.grey,
                                                        child: Icon(
                                                          Icons.euro,
                                                          color: conversion == 2
                                                              ? blueColor
                                                              : Colors.white,
                                                          size: 20,
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                GestureDetector(
                                                  onTap: () {
                                                    setconversion(3);
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        conversion == 3
                                                            ? blueColor
                                                            : Colors.grey,
                                                    radius: 20,
                                                    child: CircleAvatar(
                                                        radius: 19,
                                                        backgroundColor:
                                                            conversion == 3
                                                                ? Colors.white
                                                                : Colors.grey,
                                                        child: Icon(
                                                          Icons
                                                              .currency_bitcoin,
                                                          color: conversion == 3
                                                              ? blueColor
                                                              : Colors.white,
                                                          size: 20,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      "${AppLocalizations.of(context)!.translate("Solde en attente:")}  XAF O",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ])),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        /*Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.translate('Mon solde en Dollar')}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 14, fontFamily: content_font),
                              ),
                              Container(
                                  width: 140,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: blueColor),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    showDollar ? '0.0 \$' : '0.0 €',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        fontSize: 12, fontFamily: content_font),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),*/
                        Container(
                          height: 200,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      gridNavigation(index);
                                    },
                                    child: Column(children: [
                                      list[index]["image"],
                                      Text(
                                        list[index]["title"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: content_font,
                                            fontSize: 10,
                                            color: blueColor),
                                      ),
                                    ]),
                                  )),
                        ),
                        Container(
                            height: 40,
                            alignment: Alignment.center,
                            //color: Colors.amber,
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_left,
                                    color: blueColor,
                                    size: 40,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('auther')!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: content_font,
                                        fontSize: 15,
                                        color: blueColor),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: OmMoMo()));
                              },
                            ))
                        /* this.currrentUser!.data!.phone != ""
                            ? LastTransaction(
                                currrentUser: currrentUser,
                              )
                            : Container()*/
                      ],
                    )),
                    // BottomNavigation()
                  ],
                ),
              ),
            ));
      } else {
        return Login(
          isLogin: false,
        );
      }
    });
  }
}
