import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/country_selection_theme.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydirectcash/screens/carousel_page.dart';
import 'package:mydirectcash/screens/code_entry.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';

class PhoneNumberEntry extends StatefulWidget {
  const PhoneNumberEntry({super.key});

  @override
  _PhoneNumberEntryState createState() => _PhoneNumberEntryState();
}

class _PhoneNumberEntryState extends State<PhoneNumberEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            SizedBox(
              width: 140,
              height: 140,
              child: Image.asset(
                'assets/images/logo-alliance-transparent.png',
              ),
            ),
            Container(
              color: Colors.transparent,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'MyDirectCash Mobile',
                    style: TextStyle(
                        fontFamily: title_font,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    'AnyTime, AnyWhere, AnyPhone',
                    style: TextStyle(fontFamily: content_font, fontSize: 12),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              color: Colors.transparent,
              child: CountryListPick(
                  appBar: AppBar(
                    backgroundColor: blueColor,
                    title: const Text(
                      'Choisir un pays',
                      style: TextStyle(fontFamily: title_font, fontSize: 18),
                    ),
                  ),
                  theme: CountryTheme(
                    isShowFlag: true,
                    isShowTitle: false,
                    isShowCode: true,
                    isDownIcon: true,
                    showEnglishName: false,
                  ),
                  initialSelection: '+237',
                  onChanged: (CountryCode? code) {},
                  useUiOverlay: true,
                  useSafeArea: false),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: const TextStyle(fontFamily: content_font, fontSize: 13),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: 'Numéro de téléphone',
                    hintStyle: TextStyle(
                        fontFamily: content_font,
                        color: Colors.grey.shade500,
                        fontSize: 14)),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                           backgroundColor:  blueColor,
                            padding: const EdgeInsets.symmetric(horizontal: 50)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const CodeEntry()));
                        },
                        child: const Text(
                          'SUIVANT',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                  'Veuillez saisir votre numéro de téléphone fonctionnel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: content_font,
                      fontSize: 12,
                      color: Colors.grey.shade500)),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const CodeEntry()));
                  },
                  child: Text("J'ai déjà un compte",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: content_font,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: blueColor))),
            )
          ],
        ),
      ),
    );
  }
}
