import 'package:flutter/material.dart';
import 'package:mydirectcash/screens/rapport.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';

class ErrorOperationComponent extends StatefulWidget {
  const ErrorOperationComponent({Key? key}) : super(key: key);

  @override
  _ErrorOperationComponentState createState() =>
      _ErrorOperationComponentState();
}

class _ErrorOperationComponentState extends State<ErrorOperationComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ico-echec.png',
              width: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Echec',
                style: TextStyle(
                    fontFamily: content_font,
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: 5,
            ),
            Text(
                'Votre solde est insuffisant, veuillez le recharger via OM, MoMo, PayPal',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: content_font,
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary:
                                Colors.blueAccent.shade100.withOpacity(0.8),
                            padding: EdgeInsets.symmetric(horizontal: 20)),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Rapport()));
                        },
                        child: Text(
                          'Envoyer un rapport',
                          style: TextStyle(
                              color: blueColor,
                              fontSize: 12,
                              fontFamily: content_font),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
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
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey))),
            )
          ],
        ));
  }
}
