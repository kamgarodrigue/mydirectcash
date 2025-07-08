import 'package:flutter/material.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/achat_credit.dart';
import 'package:mydirectcash/screens/om_momo.dart';
import 'package:mydirectcash/screens/payement_marchand.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/choix_envoi_argent.dart';
import 'package:mydirectcash/widgets/choix_facture_component.dart';
import 'package:page_transition/page_transition.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      color: blueColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: AchatCredit()));
            },
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ico-achat-credit.png',
                    width: 35,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.translate('Achat de crédit')}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: content_font,
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const PayementMarchand()));
            },
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ico-paiement-marchand.png',
                    width: 35,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.translate('Payement Marchand')}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: content_font,
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const ChoixEnvoiArgent();
                  });
            },
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ico-transfert-dargent.png',
                    width: 35,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.translate('Envoi d\'argent')}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: content_font,
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: const OmMoMo()));
            },
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ico-om_momo.png',
                    width: 35,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.translate('ommom')}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: content_font,
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const ChoixFacture();
                  });
            },
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ico-facture.png',
                    width: 35,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.translate('Payement de facture')}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: content_font,
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
