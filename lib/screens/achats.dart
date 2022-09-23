import 'package:flutter/material.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/carousel_page.dart';

import 'package:mydirectcash/screens/home_guichet.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/achat_container.dart';
import 'package:mydirectcash/widgets/delete_component.dart';
import 'package:mydirectcash/widgets/share_component.dart';
import 'package:page_transition/page_transition.dart';

class Achats extends StatefulWidget {
  @override
  _AchatsState createState() => _AchatsState();
}

class _AchatsState extends State<Achats> {
  bool rechargeModule = true;
  bool servicesModule = false;

  bool envoiModule = false;

  bool airtimeModule = false;
  bool om_momoModule = false;

  bool payementModule = false;

  List<Map> achats = [
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': "Achat d'intrants",
      'num_facture': 'Num_11 35 55',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
  ];
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
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
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
                                    AppLocalizations.of(context)!
                                        .translate("GUICHET")!,
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
                                      AppLocalizations.of(context)!
                                          .translate("PRODUCTEURS")!,
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
                                            type:
                                                PageTransitionType.rightToLeft,
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
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate("Listes d'achats effectués")!,
                      style: TextStyle(
                          color: greenColor,
                          fontSize: 16,
                          fontFamily: title_font),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: marronColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(
                                            fontFamily: content_font,
                                            fontSize: 14),
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .translate("Rechercher")!,
                                            hintStyle: TextStyle(
                                                fontFamily: content_font,
                                                color: Colors.grey.shade500,
                                                fontSize: 14)))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.filter_list_outlined,
                            color: marronColor, size: 30),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: achats.length,
                    itemBuilder: (BuildContext context, int index) {
                      final achat = achats[index];

                      return AchatContainer(
                        numFacture: achat['num_facture'],
                        title: achat['title'],
                        stringDate: achat['stringDate'],
                        stringPrice: achat['stringPrice'],
                        stringSolde: achat['stringSolde'],
                        onPressShare: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return ShareComponent();
                              });
                        },
                        onPressDelete: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteComponent();
                              });
                        },
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
