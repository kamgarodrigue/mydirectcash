import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mydirectcash/AppLanguage.dart';
import 'package:mydirectcash/Controllers/UserController.dart';
import 'package:mydirectcash/Models/Transaction.dart';
import 'package:mydirectcash/Models/User.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Resset_Password_Verification.dart';
import 'package:mydirectcash/screens/carousel_page.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/bottom_navigation.dart';
import 'package:mydirectcash/widgets/choix_recharge.dart';
import 'package:mydirectcash/widgets/last_transactions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class MonCompte extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MonCompte> {
  UserController? _userController;
  bool showDollar = true;
  User? currrentUser = new User(data: DataUser(nom: "", phone: "", solde: ""));
  int conversion = 0;
  void setconversion(int value) {
    if (solde != 0) {
      switch (value) {
        case 0:
          setState(() {
            solde = context.read<AuthService>().currentUser!.data!.solde!;
            if (solde.contains(".")) {
              solde = double.tryParse(solde)!.toStringAsFixed(2);
            }
            conversion = value;
          });

          break;
        case 1:
          setState(() {
            solde = (double.tryParse(context
                        .read<AuthService>()
                        .currentUser!
                        .data!
                        .solde!)! /
                    600)
                .toString();
            if (solde.contains(".")) {
              solde = double.tryParse(solde)!.toStringAsFixed(2);
            }

            conversion = value;
          });

          break;
        case 2:
          setState(() {
            solde = (double.tryParse(context
                        .read<AuthService>()
                        .currentUser!
                        .data!
                        .solde!)! /
                    640)
                .toString();
            if (solde.contains(".")) {
              solde = double.tryParse(solde)!.toStringAsFixed(2);
            }
            conversion = value;
          });

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
    solde = solde = context.read<AuthService>().currentUser!.data!.solde!;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthService>();
    currrentUser = authProvider.currentUser;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () => _userController!.utilisateur!.then((value) {
            this.currrentUser = value;
          }),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                Icons.arrow_back,
                                size: 20,
                              )),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      currrentUser!.data!.nom.toString(),
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: 14,
                                          fontFamily: title_font),
                                    ),
                                    Text(
                                      this.currrentUser!.data!.phone.toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: content_font),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Id: " +
                                          this.currrentUser!.data!.matricule!,
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: 14,
                                          fontFamily: content_font),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        QrImageView(
                          data: authProvider.currentUser!.data!.Photo!,
                          version: QrVersions.min,
                          size: 90,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: Resset_Password_Verification()));
                      },
                      child: Text(
                        "${AppLocalizations.of(context)!.translate('Changer de Mot de Passe')}",
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontFamily: content_font),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
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
                                      builder: (BuildContext context) {
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
                          //                                                                                                                                                                                                                                                                                                                                                                                                                                           height: 249,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        solde,
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
                                                backgroundColor: conversion == 0
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
                                                          color: conversion == 0
                                                              ? blueColor
                                                              : Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            GestureDetector(
                                              onTap: () {
                                                setconversion(1);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: conversion == 1
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
                                                backgroundColor: conversion == 2
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
                                InkWell(
                                  onTap: () async {
                                    final box = context.findRenderObject()
                                        as RenderBox?;

                                    await Share.share(
                                      "https://play.google.com/store/apps/details?id=cm.directcash.alliancefinancialsa.mydirectcashmobile",
                                      sharePositionOrigin:
                                          box!.localToGlobal(Offset.zero) &
                                              box.size,
                                    );
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.share,
                                      color: blueColor,
                                      size: 20,
                                    ),
                                    title: Text(
                                      "${AppLocalizations.of(context)!.translate("Share")}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: blueColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
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

                    this.currrentUser!.data!.phone != ""
                        ? LastTransaction(
                            currrentUser: currrentUser,
                          )
                        : Container()
                  ],
                )),
                // BottomNavigation()
              ],
            ),
          ),
        ));
  }
}
