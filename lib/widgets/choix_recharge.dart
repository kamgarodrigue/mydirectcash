import 'package:flutter/material.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Recharge_carte_credit_Amount.dart';
import 'package:mydirectcash/screens/om_momo.dart';
import 'package:mydirectcash/screens/recharge_directcash.dart';
import 'package:mydirectcash/screens/recharge_om.dart';
import 'package:mydirectcash/screens/recharge_virement.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:flutter_braintree/flutter_braintree.dart';

class ChoixRecharge extends StatefulWidget {
  const ChoixRecharge({Key? key}) : super(key: key);

  @override
  State<ChoixRecharge> createState() => _ChoixRechargeState();
}

class _ChoixRechargeState extends State<ChoixRecharge> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.translate('Recharger mon compte')!,
          style: const TextStyle(
              color: Color(0xfff1034a6),
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: content_font),
        ),
        content: SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const Recharge_carte_credit_Amount()));
                },
                child: Text(
                  AppLocalizations.of(context)!
                      .translate('Carte de crédit/Paypal1')
                      .toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: content_font),
                ),
              )),
              Expanded(
                  child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const OmMoMo()));
                },
                child: Text(
                  "${AppLocalizations.of(context)!.translate('Copmte OM/MOMO1')}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: content_font),
                ),
              )),
              Expanded(
                  child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const RechargeVirement()));
                },
                child: Text(
                  "${AppLocalizations.of(context)!.translate('Virement Bancaire')}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: content_font),
                ),
              )),
              Expanded(
                  child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const RechargeDirectCash()));
                },
                child: Text(
                  "${AppLocalizations.of(context)!.translate('Transfert DirectCash')}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: content_font),
                ),
              )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        ),
                        minimumSize: WidgetStateProperty.all(
                          const Size(15, 0),
                        ),
                        overlayColor:
                            WidgetStateProperty.all((Colors.transparent)),
                        backgroundColor:
                            WidgetStateProperty.all((Colors.transparent)),
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: const BorderSide(color: Colors.white)))),
                    child: Text(
                      '${AppLocalizations.of(context)!.translate("annuler")} ',
                      style: TextStyle(
                          fontFamily: content_font,
                          color: blueColor,
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ))
            ],
          ),
        ));
  }
}
