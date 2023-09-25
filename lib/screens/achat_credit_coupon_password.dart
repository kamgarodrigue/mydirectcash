import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class AchatCreditPasswordCoupon extends StatefulWidget {
  Map? data;
  dynamic parentcontext;
  AchatCreditPasswordCoupon({Key? key, this.data, this.parentcontext})
      : super(key: key);

  @override
  _AchatCreditPasswordState createState() => _AchatCreditPasswordState();
}

class _AchatCreditPasswordState extends State<AchatCreditPasswordCoupon> {
  bool _isLoading = false;
  bool _isOscure = true;
  void togle() {
    this.setState(() {
      this._isOscure = !_isOscure;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        SizedBox(width: 50),
                        Text(
                            "${AppLocalizations.of(context)!.translate('Achat de crédit')}",
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
                    height: 20,
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
                            ' ${AppLocalizations.of(context)!.translate('Vous allez faire une recharge de')} ${widget.data!["displayName"]} ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.5,
                                fontFamily: content_font,
                                color: blueColor,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              '${AppLocalizations.of(context)!.translate('Veuillez saisir le mot de passe pour valider la transastion1')}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: content_font,
                                  fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  fontFamily: content_font, fontSize: 13),
                              textAlign: TextAlign.start,
                              initialValue: widget.data!["numero"],
                              onChanged: (value) {
                                setState(() {
                                  widget.data!["numero"] = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      "${AppLocalizations.of(context)!.translate('Saisissez le numéro bénéficiaire')}",
                                  hintStyle: TextStyle(
                                      fontFamily: content_font,
                                      color: Colors.grey,
                                      fontSize: 13))),
                          Divider(
                            height: 1.5,
                            color: blueColor,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: _isOscure,
                        style:
                            TextStyle(fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        // initialValue: widget.data!["pass"],
                        onChanged: (value) {
                          setState(() {
                            widget.data!["pass"] = value;
                          });
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.visibility,
                                size: 16,
                              ),
                              onPressed: () => togle(),
                            ),
                            hintText:
                                '${AppLocalizations.of(context)!.translate('Password')}',
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
                                print(widget.data);
                                TransactonService()
                                    .achatCreditInternational(widget.data)
                                    .then((value) {
                                  setState(() {
                                    this._isLoading = false;
                                  });
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
                                        message: "crédit envoyé avec succes",
                                      ),
                                      displayDuration: Duration(seconds: 2));
                                  Navigator.pop(context);
                                  Navigator.pop(widget.parentcontext);
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
                              },
                              child: Text(
                                '${AppLocalizations.of(context)!.translate('Valider')}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
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
                            '${AppLocalizations.of(context)!.translate('annuler')}',
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
