import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/country_selection_theme.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydirectcash/screens/carousel_page.dart';
import 'package:mydirectcash/screens/code_entry.dart';
import 'package:mydirectcash/screens/home.dart';
import 'package:mydirectcash/screens/home_guichet.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';

class InfosCompteBancaire extends StatefulWidget {
  @override
  _InfosCompteBancaireState createState() => _InfosCompteBancaireState();
}

class _InfosCompteBancaireState extends State<InfosCompteBancaire> {
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
                    padding: EdgeInsets.symmetric(horizontal: 15),
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
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    color: Colors.transparent,
                    child: Text(
                      'Informations du compte bancaire',
                      style: TextStyle(
                          fontFamily: content_font,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.5),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                              child: Row(
                            children: [
                              Expanded(
                                child: Text("Choisissez votre banque",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 15),
                                child: DropdownButton<String>(
                                  isExpanded: false,
                                  underline: Container(),
                                  icon: Icon(
                                    Icons.expand_more,
                                    color: marronColor,
                                  ),
                                  items: <String>[
                                    '',
                                    '',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: new TextStyle(
                                          fontFamily: content_font,
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    //Le coeur du changement de la traduction de l'app
                                    setState(() {
                                      //print(currentLang);
                                    });
                                  },
                                ),
                              ),
                            ],
                          )),
                          Divider(height: 1.5, color: Colors.grey),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style:
                            TextStyle(fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            hintText: 'Numéro de compte',
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
                    height: 30,
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
