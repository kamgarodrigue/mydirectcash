import 'package:flutter/material.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/envoi_comptedirectcash.dart';
import 'package:mydirectcash/screens/envoi_dargent_type_selection.dart';
import 'package:mydirectcash/screens/envoi_directcash.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';

class ChoixEnvoiArgent extends StatefulWidget {
  const ChoixEnvoiArgent({super.key});

  @override
  _ChoixEnvoiArgentState createState() => _ChoixEnvoiArgentState();
}

class _ChoixEnvoiArgentState extends State<ChoixEnvoiArgent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(vertical: 40),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: EnvoiDirectCash(
                      context1: context,
                    ),
                  )).then((value) {
                //Navigator.pop(context);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 00),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    color: blueColor.withOpacity(0.2),
                    child: Image.asset(
                      'assets/images/ico-directcash.png',
                      width: 40,
                    ),
                  ),
                  const SizedBox(
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
                            AppLocalizations.of(context)!
                                .translate("Transfert DirectCash")!,
                            style: TextStyle(
                                fontFamily: title_font,
                                color: blueColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            AppLocalizations.of(context)!.translate("detail2")!,
                            style: TextStyle(
                                fontFamily: content_font,
                                fontSize: 11.5,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: EnvoiCompteDirectCash(
                        context2: context,
                      ))); 
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    color: blueColor.withOpacity(0.2),
                    child: Image.asset(
                      'assets/images/ico-compte-direct.png',
                      width: 40,
                    ),
                  ),
                  const SizedBox(
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
                            AppLocalizations.of(context)!
                                .translate("Vers un compte DirectCash")!,
                            style: TextStyle(
                                fontFamily: title_font,
                                color: blueColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            AppLocalizations.of(context)!.translate("detail1")!,
                            style: TextStyle(
                                fontFamily: content_font,
                                fontSize: 11.5,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
