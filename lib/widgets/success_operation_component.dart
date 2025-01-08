import 'package:flutter/material.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';

class SuccessOperationComponent extends StatefulWidget {
  const SuccessOperationComponent({Key? key}) : super(key: key);

  @override
  _SuccessOperationComponentState createState() =>
      _SuccessOperationComponentState();
}

class _SuccessOperationComponentState extends State<SuccessOperationComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ico-succes.png',
              width: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Opération effectuer avec succès',
                style: TextStyle(
                    fontFamily: content_font,
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 5,
            ),
            Text('Votre solde restant est de 20 000 XAF',
                style: TextStyle(
                    fontFamily: content_font,
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 40,
            ),
            Row(
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
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: Colors.white)))),
                  child: Text(
                    'Ok',
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
            )
          ],
        ));
  }
}
