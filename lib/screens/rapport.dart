import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/screens/achat_credit_password.dart';
import 'package:mydirectcash/screens/envoi_comptedirectcash_password.dart';
import 'package:mydirectcash/screens/envoi_directcash_password.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:mydirectcash/app_localizations.dart';


class Rapport extends StatefulWidget {
  const Rapport({Key? key}) : super(key: key);

  @override
  _RapportState createState() => _RapportState();
}

class _RapportState extends State<Rapport> {
  String raport = "";
  bool _isLoading = false;
  TextEditingController trxt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthService>();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 40,
                          height: 50,
                          color: Colors.transparent,
                          child: Stack(children: [
                            Positioned(
                                top: 12,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: const Settings()));
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: blueColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(   AppLocalizations.of(context)!
                                .translate("Envoi de rapport")!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: title_font,
                                color: blueColor,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text( AppLocalizations.of(context)!
                                .translate( "Notre équipe technique va se charger de votre problème")!
,                       
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: content_font,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                  fontFamily: content_font, fontSize: 13),
                              textAlign: TextAlign.start,
                              maxLines: 5,
                              controller: trxt,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                .translate("Décrivez le problème rencontré")!,
                                  labelStyle: TextStyle(
                                      fontFamily: content_font,
                                      color: Colors.grey.shade500,
                                      fontSize: 13)),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 50),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:  blueColor,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 50)),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                authProvider.sendRaport({
                                  "phone":
                                      authProvider.currentUser!.data!.phone!,
                                  "email":
                                      authProvider.currentUser!.data!.email!,
                                  "message": trxt.text
                                }).then((value) {
                                  setState(() {
                                    _isLoading = false;
                                    trxt.clear();
                                  });
                                  showTopSnackBar(
                                   Overlay.of(context),
                                    CustomSnackBar.success(
                                      message: value.toString() +  AppLocalizations.of(context)!
                                .translate("Rapport envoyé avec succes")!,
                                          
                                    ),
                                  );
                                }).catchError((errror) {
                                  print(errror);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message: "Erreur $errror:",
                                    ),
                                  );
                                });
                              },
                              child: Text(
                               AppLocalizations.of(context)!
                                .translate("Envoyer un rapport")! ,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(   AppLocalizations.of(context)!
                                .translate("annuler")! ,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: content_font,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey))),
                  )
                ],
              ),
            ),
            Container(
                child: _isLoading
                    ? Loader(loadingTxt:  AppLocalizations.of(context)!
                                .translate( "Envois encour")! )
                    : Container())
          ],
        ));
  }
}
