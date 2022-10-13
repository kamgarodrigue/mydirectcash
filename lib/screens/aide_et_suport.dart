import 'package:flutter/material.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/rapport.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatefulWidget {
  Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover)),
            child: ListView(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                            )),
                        Container(
                          width: 40,
                          height: 100,
                          color: Colors.transparent,
                          child: Stack(children: [
                            Positioned(
                                top: 30,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: Settings()));
                                  },
                                  child: Image.asset(
                                    'assets/images/ico-parametre.png',
                                    width: 40,
                                  ),
                                ))
                          ]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 140,
                    child: Image.asset(
                      'assets/images/logo-alliance-transparent.png',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.translate('title')}",
                          style: const TextStyle(
                              fontFamily: title_font,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          "${AppLocalizations.of(context)!.translate('message')}",
                          style: const TextStyle(
                              fontFamily: content_font, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.translate('aide')}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: content_font,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  InkWell(
                    onTap: () {
                      var whatsappUrl = "whatsapp://send?phone=+237681176708";
                      try {
                        launch(whatsappUrl);
                      } catch (e) {
                        //To handle error and display error message
                        showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: "Unable to open whatsapp",
                            ),
                            displayDuration: Duration(seconds: 2));
                      }
                    },
                    child: Card(
                        elevation: 1,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Whatsapp",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color.fromRGBO(37, 211, 102, 1),
                                    fontFamily: content_font,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.translate('whatsappMessage')}",
                                style: const TextStyle(
                                    color: Color.fromRGBO(37, 211, 102, 1),
                                    fontFamily: content_font,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Rapport()));
                    },
                    child: Card(
                        elevation: 1,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Email",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: blueColor,
                                    fontFamily: content_font,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.translate('emailMessage')}",
                                style: TextStyle(
                                    color: blueColor,
                                    fontFamily: content_font,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Card(
                        elevation: 1,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Faqs",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: content_font,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.translate('FaqsMessage')}",
                                style: const TextStyle(
                                    fontFamily: content_font, fontSize: 12),
                              ),
                            ],
                          ),
                        )),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
