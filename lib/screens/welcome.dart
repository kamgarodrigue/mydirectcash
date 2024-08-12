import 'package:flutter/material.dart';
import 'package:mydirectcash/AppLanguage.dart';
import 'package:mydirectcash/Controllers/UserController.dart';
import 'package:mydirectcash/Models/User.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/screens/carousel_page.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/widgets/settingstab_option.dart';
import 'package:page_transition/page_transition.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: const DecorationImage(
                image: const AssetImage('assets/images/background.png'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.2,
              padding: const EdgeInsets.only(bottom: 50),
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo-alliance-transparent.png',
                        width: 80,
                      ),
                      Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.translate('title').toString()}",
                              style: const TextStyle(
                                  fontFamily: title_font,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${AppLocalizations.of(context)!.translate('message')}",
                              maxLines: 2,
                              style: const TextStyle(
                                  fontFamily: content_font, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/ico-suivant.png',
                          width: 50,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: CarouselPage()));
                            },
                            child: Text(
                              "${AppLocalizations.of(context)!.translate('Commencer')}",
                              style: TextStyle(
                                  color: blueColor,
                                  fontSize: 15,
                                  fontFamily: content_font),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
