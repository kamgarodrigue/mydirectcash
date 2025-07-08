import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Grille_Tarifaire_model.dart';
import 'package:mydirectcash/screens/Recharge_carte_credit_Token.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Grille_Tarifaire extends StatefulWidget {
  const Grille_Tarifaire({Key? key}) : super(key: key);

  @override
  State<Grille_Tarifaire> createState() => _Grille_TarifaireState();
}

class _Grille_TarifaireState extends State<Grille_Tarifaire> {
  final bool _isLoading = false;
  bool _isOscure = true;
  String montant = "";

  void togle() {
    setState(() {
      _isOscure = !_isOscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = [
      {
        "title": AppLocalizations.of(context)!.translate('Envoi d\'argent'),
        "image": 'assets/images/ico-transfert-dargent.png',
        "model": "moneyXferFees"
      },
      {
        "title": "collecte",
        "image": 'assets/images/ico-transfert-dargent.png',
        "model": "collecteFees"
      },
      {"title": "Eneo", "image": 'assets/images/eneo.png', "model": "eneoFees"},
      {
        "title": "Camwater",
        "image": 'assets/images/cam_water.jpg',
        "model": "camwaterFees"
      },
    ];
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
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
                                            child: const Settings()));
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
                        const SizedBox(width: 50),
                        Text(
                            "${AppLocalizations.of(context)!.translate('tarif')}",
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
                  const SizedBox(
                    height: 50,
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Grille_Tarifaire_model(
                                    model: list[index]["model"],
                                    title: list[index]['title'],
                                  )));
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                list[index]["image"],
                                // color: Colors.black,
                                width: 35,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                list[index]['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: content_font,
                                    fontSize: 10,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
                child: _isLoading
                    ? const Loader(loadingTxt: 'Content is loading...')
                    : Container())
          ],
        ));
  }
}
