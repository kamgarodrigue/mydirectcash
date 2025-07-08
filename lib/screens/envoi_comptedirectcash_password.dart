import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/app_routes.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';

class EnvoiCompteDirectCashPassword extends StatefulWidget {
  Map? data;
  dynamic context1;
  dynamic context2;
  String nom;
  EnvoiCompteDirectCashPassword(
      {Key? key,
      required this.data,
      this.context1,
      this.context2,
      required this.nom})
      : super(key: key);

  @override
  _EnvoiCompteDirectCashPasswordState createState() =>
      _EnvoiCompteDirectCashPasswordState();
}

class _EnvoiCompteDirectCashPasswordState
    extends State<EnvoiCompteDirectCashPassword> {
  bool _isLoading = false;
  bool _isOscure = true;
  void togle() {
    setState(() {
      _isOscure = !_isOscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totaldebite = double.tryParse(widget.data?['vAmount'])! +
        double.tryParse(widget.data?["vRate"])!;

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
                        Text(
                            AppLocalizations.of(context)!
                                .translate("Envoi - Compte MyDirectCash")!,
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
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/logo-alliance-transparent.png',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontFamily: content_font,
                              fontWeight: FontWeight.w500,
                              color: Colors.black, // Couleur par défaut
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.translate("Vous allez faire une recharge de")!} '),
                              TextSpan(
                                text: '${widget.data?['vAmount']} XAF',
                                style: TextStyle(color: blueColor),
                              ),
                              TextSpan(
                                  text:
                                      ' ${AppLocalizations.of(context)!.translate("au numéro")!} '),
                              TextSpan(
                                text: '${widget.data?['vToNumber']}',
                                style: TextStyle(color: blueColor),
                              ),
                              const TextSpan(text: ' de Nom: '),
                              TextSpan(
                                text: widget.nom,
                                style: TextStyle(color: blueColor),
                              ),
                              const TextSpan(text: ', frais de '),
                              TextSpan(
                                text: '${widget.data?['vRate']} XAF',
                                style: TextStyle(color: blueColor),
                              ),
                              const TextSpan(
                                  text: '. Montant total à débiter '),
                              TextSpan(
                                text: '$totaldebite XAF',
                                style: TextStyle(color: blueColor),
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: _isOscure,
                        // initialValue: widget.data.pass,
                        onChanged: (value) {
                          setState(() {
                            widget.data?['vPIN'] = value;
                          });
                        },
                        style: const TextStyle(
                            fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                size: 16,
                              ),
                              onPressed: () => togle(),
                            ),
                            hintText: 'Mot de passe',
                            hintStyle: TextStyle(
                                fontFamily: content_font,
                                color: Colors.grey.shade500,
                                fontSize: 13)),
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
                                  backgroundColor: blueColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50)),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                TransactonService()
                                    .EnvoiCompteDirectcash(widget.data)
                                    .then((value) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  print(value["message"]);
                                  if (value["message"] ==
                                      "Mot de passe ou PIN incorrect.") {
                                    DialogWidget.success(
                                      context,
                                      title: "",
                                      content: value['message'],
                                      color: errorColor,
                                      callback: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  } else if (value['message'] ==
                                      "Erreur interne du serveur lors de l'appel de la procédure stockée.") {
                                    DialogWidget.success(
                                      context,
                                      title: AppLocalizations.of(context)!
                                          .translate("erreur")!,
                                      content: value["message"],
                                      color: errorColor,
                                      callback: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  } else if (value['message'] ==
                                      "Client inexistant") {
                                    DialogWidget.success(
                                      context,
                                      title: AppLocalizations.of(context)!
                                          .translate("erreur")!,
                                      content: value["message"],
                                      color: errorColor,
                                      callback: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  } else if (value["message"] == "Succes") {
                                    DialogWidget.success(
                                      context,
                                      title: value["message"],
                                      content: value['data']['sender'],
                                      color: greenColor,
                                      callback: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.homePage,
                                          (route) => false,
                                        );
                                      },
                                    );
                                  } else {
                                    DialogWidget.success(
                                      context,
                                      title: value["message"],
                                      content: value['data']['sender'],
                                      color: greenColor,
                                      callback: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  }
                                }).catchError((error) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  print(error);

                                  DialogWidget.error(
                                    context,
                                    title: AppLocalizations.of(context)!
                                        .translate("erreur")!,
                                    content: '',
                                    color: errorColor,
                                    callback: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("Valider")!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17),
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
                        child: Text(
                            AppLocalizations.of(context)!.translate("annuler")!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: content_font,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: blueColor))),
                  )
                ],
              ),
            ),
            Container(
                child: _isLoading
                    ? const Loader(loadingTxt: 'Content is loading...')
                    : Container())
          ],
        ));
  }
}
