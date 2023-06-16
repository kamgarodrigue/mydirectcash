import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/DetailTransaction.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:mydirectcash/widgets/choix_payement_mode_component.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class EnvoiCompteDirectCashPassword extends StatefulWidget {
  DataTransaction data;
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
    this.setState(() {
      this._isOscure = !_isOscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totaldebite = double.tryParse(widget.data.amount!)! +
        double.tryParse(widget.data.rate!)!;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
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
                  SizedBox(
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
                        SizedBox(width: 20),
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/logo-alliance-transparent.png',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                            '${AppLocalizations.of(context)!.translate("Vous allez faire une recharge de")!} ${widget.data.amount} XAF ${AppLocalizations.of(context)!.translate("au numéro")!} ${widget.data.toNumber!.substring(0, 3)} ** ** ${widget.data.toNumber!.substring(7, 9)} de Nom: ${widget.nom}, frais de ${widget.data.rate} XAF. Montant total à débiter $totaldebite XAF.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.5,
                                fontFamily: content_font,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: _isOscure,
                        initialValue: widget.data.pass,
                        onChanged: (value) {
                          setState(() {
                            widget.data.pass = value;
                          });
                        },
                        style:
                            TextStyle(fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
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
                  SizedBox(height: 50),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: blueColor,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50)),
                              onPressed: () {
                                setState(() {
                                  this._isLoading = true;
                                });
                                print(widget.data.toJson());
                                TransactonService()
                                    .EnvoiCompteDirectcash(
                                        widget.data, widget.nom)
                                    .then((value) {
                                  setState(() {
                                    this._isLoading = false;
                                  });
                                  print(value);
                                  context
                                      .read<AuthService>()
                                      .loginWithBiometric({
                                    "id": context
                                        .read<AuthService>()
                                        .currentUser!
                                        .data!
                                        .phone
                                  });
                                  showTopSnackBar(
                                      context,
                                      CustomSnackBar.success(
                                        message: json.decode(
                                            value.toString())['message'],
                                      ),
                                      displayDuration: Duration(seconds: 2));
                                  Navigator.pop(widget.context1);
                                  Navigator.pop(widget.context2);
                                  Navigator.pop(context);
                                }).catchError((error) {
                                  setState(() {
                                    this._isLoading = false;
                                  });
                                  print(error);
                                  showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                        message: AppLocalizations.of(context)!
                                            .translate("erreur")!,
                                      ),
                                      displayDuration: Duration(seconds: 2));
                                });
                                /* showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return ChoixPayementModeComponent();
                                });*/
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("Valider")!,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
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
                    ? Loader(loadingTxt: 'Content is loading...')
                    : Container())
          ],
        ));
  }
}
