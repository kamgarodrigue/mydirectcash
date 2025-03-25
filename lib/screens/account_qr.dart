import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/screens/achats.dart';
import 'package:mydirectcash/screens/carousel_page.dart';

import 'package:mydirectcash/screens/guichet_achat_produit.dart';
import 'package:mydirectcash/screens/home_guichet.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/transactions.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AccountQR extends StatefulWidget {
  const AccountQR({super.key});

  @override
  _AccountQRState createState() => _AccountQRState();
}

class _AccountQRState extends State<AccountQR> {
  bool showDollar = true;
  @override
  void initState() {
    super.initState();
    context.read<AuthService>().authenticate;
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
      body: Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 20,
                          )),
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
                                          type: PageTransitionType.rightToLeft,
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
                  height: 120,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 20),
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
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Noms',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: content_font),
                                    ),
                                    Text(
                                      'Telephone',
                                      style:
                                          TextStyle(fontFamily: content_font),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Identifiant',
                                      style:
                                          TextStyle(fontFamily: content_font),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 70,
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      authProvider.currentUser!.data!.nom!,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: greenColor,
                                          fontFamily: title_font),
                                    ),
                                    Text(
                                      authProvider.currentUser!.data!.phone!,
                                      style: TextStyle(
                                          fontFamily: content_font,
                                          color: greenColor),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      authProvider
                                          .currentUser!.data!.matricule!,
                                      style: TextStyle(
                                          fontFamily: content_font,
                                          color: greenColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                QrImageView(
                  data: authProvider.currentUser!.data!.Photo!,
                  size: 300.0,
                ),
                const SizedBox(
                  height: 35,
                ),
                Container(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("Retour",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: content_font,
                              //fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: blueColor))),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
