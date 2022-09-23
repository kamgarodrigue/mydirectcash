import 'package:flutter/material.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';

class DeleteComponent extends StatefulWidget {
  @override
  _DeleteComponentState createState() => _DeleteComponentState();
}

class _DeleteComponentState extends State<DeleteComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      child: ListView(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Supprimer cette transaction?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: title_font,
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                      fontSize: 12.5),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            padding: EdgeInsets.symmetric(horizontal: 40)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Annuler',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 00,
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: blueColor,
                            padding: EdgeInsets.symmetric(horizontal: 40)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Supprimer',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
