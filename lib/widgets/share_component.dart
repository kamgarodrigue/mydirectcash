import 'package:flutter/material.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';

class ShareComponent extends StatefulWidget {
  @override
  _ShareComponentState createState() => _ShareComponentState();
}

class _ShareComponentState extends State<ShareComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 25, bottom: 20, top: 40, right: 25),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.indigo.withOpacity(0.2),
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dépôt OM',
                            style: TextStyle(
                                fontFamily: title_font,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '20 000,0 XAF',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: title_font,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                        Text('Lun 22/05/21 - 15:20',
                            style: TextStyle(
                                fontFamily: content_font,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                                fontSize: 9)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Text(
              'Partager la transaction via',
              style: TextStyle(
                  fontFamily: title_font,
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                  fontSize: 12.5),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/images/whatsapp-fill.png',
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "WhatsApp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: content_font,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/images/whatsapp-fill.png',
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "WhatsApp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: content_font,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/images/whatsapp-fill.png',
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "WhatsApp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: content_font,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/images/whatsapp-fill.png',
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "WhatsApp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: content_font,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/images/whatsapp-fill.png',
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "WhatsApp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: content_font,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/images/whatsapp-fill.png',
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "WhatsApp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: content_font,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/images/whatsapp-fill.png',
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "WhatsApp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: content_font,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/images/whatsapp-fill.png',
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "WhatsApp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: content_font,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          padding: EdgeInsets.symmetric(horizontal: 50)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Annuler le partage',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
