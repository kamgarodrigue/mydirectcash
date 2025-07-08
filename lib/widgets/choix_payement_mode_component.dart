import 'package:flutter/material.dart';
import 'package:mydirectcash/screens/recharge_directcash.dart';
import 'package:mydirectcash/screens/recharge_om.dart';
import 'package:mydirectcash/screens/recharge_virement.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/payement_option.dart';
import 'package:page_transition/page_transition.dart';

class ChoixPayementModeComponent extends StatefulWidget {
  const ChoixPayementModeComponent({super.key});

  @override
  _ChoixPayementModeComponentState createState() =>
      _ChoixPayementModeComponentState();
}

class _ChoixPayementModeComponentState
    extends State<ChoixPayementModeComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Text(
              'Choisissez le mode de paiement',
              style: TextStyle(
                  fontFamily: title_font,
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                  fontSize: 14),
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: GestureDetector(
                onTap: () {},
                child: PayementModeOption(
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 18,
                    ),
                    title: 'Carte de crédit / Paypal')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const RechargeOM(),
                      )).then((value) {
                    Navigator.pop(context);
                  });
                },
                child: PayementModeOption(
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 18,
                    ),
                    title: 'Compte OM / MoMo')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const RechargeVirement(),
                      )).then((value) {
                    Navigator.pop(context);
                  });
                },
                child: PayementModeOption(
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 18,
                    ),
                    title: 'Virement Bancaire')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const RechargeDirectCash()))
                      .then((value) {
                    Navigator.pop(context);
                  });
                },
                child: PayementModeOption(
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 18,
                    ),
                    title: 'Transfert DirectCash')),
          ),
        ],
      ),
    );
  }
}
