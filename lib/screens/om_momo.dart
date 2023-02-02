import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mydirectcash/screens/AchatCreditMOMOPassword.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mydirectcash/Controllers/UserController.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:mydirectcash/app_localizations.dart';

class OmMoMo extends StatefulWidget {
  @override
  _OmMoMoState createState() => _OmMoMoState();
}

class _OmMoMoState extends State<OmMoMo> {
  Map data = {
    "senderNumber": "",
    "operateur": "CMMTNMOMO",
    "Id": "",
    "pass": "",
    "reseau": "CMMTNMOMO",
    "montant": "",
    "numero": "",
    "opType": "Retrait"
  };
  bool isOm = true, _isLoading = false;
  bool isDepot = false;
  bool _isOscure = true;
  void togle() {
    this.setState(() {
      this._isOscure = !_isOscure;
    });
  }

  @override
  void initState() {
    super.initState();
    UserController().utilisateur!.then((value) {
      print(value.data!.phone);
      setState(() {
        data["Id"] = value.data!.phone;
      });
    });
  }

  Widget depot() {
    print('object');
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: data["senderNumber"],
                    onChanged: (value) {
                      setState(() {
                        data["senderNumber"] = value;
                      });
                    },
                    style: TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!
                            .translate('Saisissez le numéro bénéficiaire'),
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
        Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: data["montant"],
                    onChanged: (value) {
                      setState(() {
                        data["montant"] = value;
                      });
                    },
                    style: TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!
                            .translate('Saisire montant'),
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
        Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: _isOscure,
                    initialValue: data["pass"],
                    onChanged: (value) {
                      setState(() {
                        data["pass"] = value;
                      });
                    },
                    style: TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.visibility,
                            size: 16,
                          ),
                          onPressed: () => togle(),
                        ),
                        border: InputBorder.none,
                        hintText:
                            AppLocalizations.of(context)!.translate('Password'),
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
        SizedBox(height: 50),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: blueColor,
                        padding: EdgeInsets.symmetric(horizontal: 50)),
                    onPressed: () {
                      setState(() {
                        this._isLoading = true;
                      });
                      TransactonService().depotMomo(data).then((value) {
                        setState(() {
                          this._isLoading = false;
                          data = {
                            "senderNumber": "",
                            "operateur": isOm ? "CMORANGEOM" : "CMMTNMOMO",
                            "Id": "",
                            "pass": "",
                            "reseau": "",
                            "montant": "",
                            "numero": "",
                            "opType": "Dépôt"
                          };
                        });
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            message: value.toString(),
                          ),
                        );
                        // Navigator.pop(context);
                      }).catchError((error) {
                        print(error);
                        setState(() {
                          this._isLoading = false;
                        });
                        showTopSnackBar(
                          context,
                          CustomSnackBar.error(
                            message: AppLocalizations.of(context)!
                                .translate("erreur")!,
                          ),
                        );
                      });

                      /* Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: AchatCreditMOMOPassword(
                                data: data,
                              )));*/
                    },
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('Valider')
                          .toString(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget retrait() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: data["Id"],
                    onChanged: (value) {
                      setState(() {
                        data["Id"] = value;
                      });
                    },
                    style: TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!
                            .translate('Numero du compte')
                            .toString(),
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
        Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: data["montant"],
                    onChanged: (value) {
                      setState(() {
                        data["montant"] = value;
                      });
                    },
                    style: TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!
                            .translate('Saisire montant')
                            .toString(),
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
        Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: _isOscure,
                    initialValue: data["pass"],
                    onChanged: (value) {
                      setState(() {
                        data["pass"] = value;
                      });
                    },
                    style: TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.visibility,
                            size: 16,
                          ),
                          onPressed: () => togle(),
                        ),
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!
                            .translate('Password')
                            .toString(),
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
        SizedBox(height: 50),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: blueColor,
                        padding: EdgeInsets.symmetric(horizontal: 50)),
                    onPressed: () {
                      setState(() {
                        this._isLoading = true;
                      });
                      TransactonService().retraitMomo(data).then((value) {
                        setState(() {
                          this._isLoading = false;
                          data = {
                            "senderNumber": "",
                            "operateur": isOm ? "CMORANGEOM" : "CMMTNMOMO",
                            "Id": "",
                            "pass": "",
                            "reseau": "",
                            "montant": "",
                            "numero": "",
                            "opType": "Retrait"
                          };
                        });
                        print(value);
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            message: value.toString(),
                          ),
                        );
                        // Navigator.pop(context);
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
                        );
                      });

                      /* Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: AchatCreditMOMOPassword(
                                data: data,
                              )));*/
                    },
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('Valider')
                          .toString(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
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
                      padding: EdgeInsets.symmetric(horizontal: 25),
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
                                              type: PageTransitionType
                                                  .rightToLeft,
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
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
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
                          Text('OM / MoMo',
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
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/images/logo-alliance-transparent.png',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .translate('Chose operator')
                          .toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: title_font,
                          color: blueColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isOm = true;
                                data["operateur"] = "CMORANGEOM";
                              });
                              print(data["operateur"]);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/om.png',
                                        ),
                                        fit: BoxFit.cover)),
                                child: new ClipRect(
                                    child: new BackdropFilter(
                                  filter: new ImageFilter.blur(
                                      sigmaX: isOm ? 0.0 : 2.0,
                                      sigmaY: isOm ? 0.0 : 2.0),
                                  child: new Container(
                                    padding: EdgeInsets.all(0),
                                    decoration: new BoxDecoration(
                                        color: Colors.black.withOpacity(0.2)),
                                    child: new Center(
                                      child: new Text('',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2),
                                    ),
                                  ),
                                ))),
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isOm = false;
                                data["operateur"] = "CMMTNMOMO";
                              });
                              print(data["operateur"]);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/mtn_momo.png',
                                        ),
                                        fit: BoxFit.cover)),
                                child: new ClipRect(
                                    child: new BackdropFilter(
                                  filter: new ImageFilter.blur(
                                      sigmaX: !isOm ? 0.0 : 2.0,
                                      sigmaY: !isOm ? 0.0 : 2.0),
                                  child: new Container(
                                    padding: EdgeInsets.all(0),
                                    decoration: new BoxDecoration(
                                        color: Colors.black.withOpacity(0.2)),
                                    child: new Center(
                                      child: new Text('',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2),
                                    ),
                                  ),
                                ))),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            isOm
                                ? 'assets/images/orange_money.jpeg'
                                : 'assets/images/mobile_money.png',
                            width: 70,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate(
                                            'Choisissez le type de transaction')
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: title_font,
                                        color: blueColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .translate('Dépôt')
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          content_font)),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Radio(
                                                    value: isDepot,
                                                    activeColor: blueColor,
                                                    groupValue: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        isDepot = true;
                                                        data["opType"] =
                                                            "Depos";
                                                      });
                                                      print(data["opType"]);
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .translate('Retrait')
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          content_font)),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Radio(
                                                    activeColor: blueColor,
                                                    value: !isDepot,
                                                    groupValue: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        isDepot = false;
                                                        data["opType"] =
                                                            "Retrait";
                                                      });
                                                      print(data["opType"]);
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    this.isDepot ? depot() : retrait(),
                  ],
                )),
            Container(
                child: _isLoading
                    ? Loader(loadingTxt: 'Content is loading...')
                    : Container())
          ],
        ));
  }
}
