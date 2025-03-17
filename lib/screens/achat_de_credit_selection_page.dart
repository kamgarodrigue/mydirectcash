import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mydirectcash/Repository/OperationServices.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/achat_credit.dart';
import 'package:mydirectcash/screens/achat_credit_other.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AchatDeCreditSelectionPage extends StatefulWidget {
  const AchatDeCreditSelectionPage({super.key});

  @override
  State<AchatDeCreditSelectionPage> createState() =>
      _AchatDeCreditSelectionPageState();
}

class _AchatDeCreditSelectionPageState
    extends State<AchatDeCreditSelectionPage> {
  Map data = {
    "vClientID": "",
    "vAmount": "",
    "vToNumber": "",
    "vCNI": " ",
    "vPIN": "",
    "vreseau": "",
    // "trxTYPE": "",
    "opType": "airtime"
  };

  @override
  Widget build(BuildContext context) {
    final operationServices = context.watch<OperationServices>();
    Widget customLangButton(
      Function callback,
      String img,
      int index,
      Widget page,
    ) {
      return ElevatedButton(
        onPressed: () {
          callback();
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: page));
        },
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SvgPicture.asset(img, height: 50, width: 50),
        ),
      );
    }

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
                                          type: PageTransitionType.rightToLeft,
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
                Row(
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
                      // "${AppLocalizations.of(context)!.translate('Achat de crédit')}",
                      "Type de Transaction",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: title_font,
                          color: blueColor,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    'assets/images/logo-alliance-transparent.png',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customLangButton(() {
                                // setState(() {
                                //   data["trxTYPE"] = "13";
                                // });
                              },
                                  "assets/svg/local.svg",
                                  0,
                                  AchatCreditauther(
                                    data: data,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Locale",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: blueColor,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customLangButton(
                                () {
                                // setState(() {
                                //   data["trxTYPE"] = "14";
                                // });
                              },
                                  "assets/svg/world.svg", 1, AchatCredit()),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Internationale",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: blueColor),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
