import 'package:flutter/material.dart';
import 'package:mydirectcash/screens/achats.dart';
import 'package:mydirectcash/screens/carousel_page.dart';
import 'package:mydirectcash/screens/guichet_achat_produit.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/transactions.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';

class HomeGuichet extends StatefulWidget {
  const HomeGuichet({super.key});

  @override
  _HomeGuichetState createState() => _HomeGuichetState();
}

class _HomeGuichetState extends State<HomeGuichet> {
  bool showDollar = true;
  @override
  Widget build(BuildContext context) {
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 80,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/logo-guichet-producteur.png',
                                height: 70,
                              ),
                              Positioned(
                                top: 55,
                                left: 3,
                                child: Text(
                                  'GUICHET',
                                  style: TextStyle(
                                      color: marronColor,
                                      fontSize: 15,
                                      fontFamily: title_font),
                                ),
                              ),
                              Positioned(
                                  top: 70,
                                  left: 4,
                                  child: Text(
                                    'PRODUCTEURS',
                                    style: TextStyle(
                                        color: marronColor.withOpacity(0.5),
                                        fontSize: 8.8,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: content_font),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 100,
                        color: Colors.transparent,
                        child: Stack(children: [
                          Positioned(
                              top: 28,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: HomeGuichet()));
                                },
                                child: Icon(Icons.home,
                                    color: marronColor, size: 35),
                              ))
                        ]),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 00,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          child: Row(
                            children: [
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
                                      'John DOE',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: greenColor,
                                          fontFamily: title_font),
                                    ),
                                    Text(
                                      'OU672443320',
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
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: const Icon(Icons.qr_code, size: 90),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  color: Colors.transparent,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Solde courant',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 14, fontFamily: content_font),
                      ),
                      Text(
                        '0 XAF',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 34, fontFamily: title_font),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showDollar = true;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              showDollar ? marronColor : Colors.grey,
                          radius: 20,
                          child: CircleAvatar(
                              radius: 19,
                              backgroundColor:
                                  showDollar ? marronColor : Colors.grey,
                              child: const Icon(
                                Icons.attach_money,
                                color: Colors.white,
                                size: 20,
                              )),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showDollar = false;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              !showDollar ? marronColor : Colors.grey,
                          radius: 20,
                          child: CircleAvatar(
                              radius: 19,
                              backgroundColor:
                                  !showDollar ? marronColor : Colors.grey,
                              child: const Icon(
                                Icons.euro,
                                color: Colors.white,
                                size: 20,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Mon solde en Dollar',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14, fontFamily: content_font),
                          ),
                          Container(
                              width: 140,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: marronColor),
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
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                               backgroundColor:   marronColor,
                                padding: const EdgeInsets.symmetric(horizontal: 50)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: GuichetAchatProduit()));
                            },
                            child: const Text(
                              'Achetez un produit',
                              style: TextStyle(
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
                const SizedBox(height: 10),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                               backgroundColor:  marronColor,
                                padding: const EdgeInsets.symmetric(horizontal: 75)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: Achats()));
                            },
                            child: const Text(
                              'Mes achats',
                              style: TextStyle(
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
                const SizedBox(
                  height: 80,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: marronColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Row(children: [
                        Icon(Icons.chevron_right, size: 18, color: marronColor),
                        Text(
                          'Dernières transactions',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              //fontSize: 14,
                              fontFamily: content_font,
                              color: marronColor),
                        ),
                      ]),
                      const Padding(
                        padding: EdgeInsets.only(left: 18, top: 5),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 18, top: 0),
                              child: Text(
                                'Envoi d\'argent',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: content_font,
                                ),
                              ),
                            ),
                            Text(
                              '20 000,0 XAF',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: content_font,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ]),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 18, top: 0),
                              child: Text(
                                'Vers TALLA jean (6 55 ** ** **)',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: content_font,
                                ),
                              ),
                            ),
                            Text(
                              '22/05/21 - 15:20',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: content_font,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                      const Padding(
                        padding: EdgeInsets.only(left: 18, top: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
