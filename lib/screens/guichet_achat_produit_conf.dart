import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/country_selection_theme.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydirectcash/screens/carousel_page.dart';
import 'package:mydirectcash/screens/code_entry.dart';
import 'package:mydirectcash/screens/home.dart';
import 'package:mydirectcash/screens/home_guichet.dart';
import 'package:mydirectcash/screens/infos_compte.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';

class GuichetAchatProduitConf extends StatefulWidget {
  @override
  _GuichetAchatProduitConfState createState() =>
      _GuichetAchatProduitConfState();
}

class _GuichetAchatProduitConfState extends State<GuichetAchatProduitConf> {
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
        child: Stack(
          children: [
            /*Positioned(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/logo-guichet-producteur.png'),
                      fit: BoxFit.cover),
                  color: Colors.white.withOpacity(0.1),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Text(''),
              ),
            ),*/
            Positioned(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/logo-guichet-producteur.png',
                                  height: 80,
                                ),
                                Positioned(
                                  top: 65,
                                  left: 8,
                                  child: Text(
                                    'GUICHET',
                                    style: TextStyle(
                                        color: marronColor,
                                        fontSize: 15,
                                        fontFamily: title_font),
                                  ),
                                ),
                                Positioned(
                                    top: 82,
                                    left: 10,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    color: Colors.transparent,
                    child: Text(
                      'Achats de produits ',
                      style: TextStyle(
                          fontFamily: content_font,
                          color: greenColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.5),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      children: [
                        Text(
                            'Vous allez faire des achats de 20 000XAF chez OU688******, frais de 150 XAF. Montant total à débiter 20 150 XAF',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.5,
                                fontFamily: content_font,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style:
                            TextStyle(fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            focusColor: marronColor,
                            suffixIcon: Icon(
                              Icons.visibility,
                              size: 16,
                            ),
                            hintText: 'Mot de passe DirectCash',
                            hintStyle: TextStyle(
                                fontFamily: content_font,
                                color: Colors.grey.shade500,
                                fontSize: 13)),
                      )),
                  SizedBox(
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
                                  primary: marronColor,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: HomeGuichet()));
                              },
                              child: Text(
                                'Valider',
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
                    height: 35,
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text("Annuler",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: content_font,
                                //fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: marronColor))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
