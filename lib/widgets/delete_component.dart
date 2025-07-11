import 'package:flutter/material.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';

class DeleteComponent extends StatefulWidget {
  const DeleteComponent({super.key});

  @override
  _DeleteComponentState createState() => _DeleteComponentState();
}

class _DeleteComponentState extends State<DeleteComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 25, bottom: 20, top: 40, right: 25),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                      child: const Column(
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
                        const Text(
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
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(horizontal: 40)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Annuler',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 00,
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                           backgroundColor:   blueColor,
                            padding: const EdgeInsets.symmetric(horizontal: 40)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
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
