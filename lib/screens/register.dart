import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/country_selection_theme.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/ValidateAccount.dart';
import 'package:mydirectcash/screens/carousel_page.dart';
import 'package:mydirectcash/screens/code_entry.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class Register extends StatefulWidget {
  Function? goToLogin;
  Function? goreturn;
  Function? completpROfile;
  Register({this.goToLogin, this.completpROfile, this.goreturn});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  /* Map dataUser = {
    "Pass": "123456",
    "Nom": "Mopot tes",
    "Phone": "681176708",
    "Ville": "Yde",
    "Adresse": "Emaa",
    "Photo": "DirectCash",
    "Email": "tes121@ts.com"
  };*/
  Map dataUser = {
    "Pass": "",
    "Nom": "",
    "Phone": "",
    "Ville": "",
    "Adresse": "",
    "Photo": "",
    "Email": ""
  };
  bool _isOscure = true;
  bool _isverify = false;
  void togle() {
    this.setState(() {
      this._isOscure = !_isOscure;
    });
  }

  bool _isLoading = false;
  final _keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return _isverify
        ? ValidateAccount(
            phoneNumber: dataUser["Phone"],
            goToLogin: () {
              setState(() {
                _isverify = false;
                widget.goToLogin!();
              });
            },
          )
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.cover)),
                  child: ListView(
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        child: Image.asset(
                          'assets/images/logo-alliance-transparent.png',
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.translate('title')}",
                              style: TextStyle(
                                  fontFamily: title_font,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              "${AppLocalizations.of(context)!.translate('message')}",
                              style: TextStyle(
                                  fontFamily: content_font, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _keyform,
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: dataUser["Phone"],
                              onChanged: (val) {
                                dataUser["Phone"] = val;
                              },
                              style: TextStyle(
                                  fontFamily: content_font, fontSize: 14),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  hintText:
                                      "${AppLocalizations.of(context)!.translate('Phone')}",
                                  hintStyle: TextStyle(
                                      fontFamily: content_font,
                                      color: Colors.grey.shade500,
                                      fontSize: 14)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: dataUser["Nom"],
                              onChanged: (val) {
                                dataUser["Nom"] = val;
                              },
                              style: TextStyle(
                                  fontFamily: content_font, fontSize: 14),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  hintText:
                                      "${AppLocalizations.of(context)!.translate('name')}",
                                  hintStyle: TextStyle(
                                      fontFamily: content_font,
                                      color: Colors.grey.shade500,
                                      fontSize: 14)),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontFamily: content_font, fontSize: 14),
                                textAlign: TextAlign.start,
                                initialValue: dataUser["Email"],
                                onChanged: (val) {
                                  dataUser["Email"] = val;
                                },
                                decoration: InputDecoration(
                                    hintText:
                                        "${AppLocalizations.of(context)!.translate('email')}",
                                    hintStyle: TextStyle(
                                        fontFamily: content_font,
                                        color: Colors.grey.shade500,
                                        fontSize: 14)),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: _isOscure,
                                style: TextStyle(
                                    fontFamily: content_font, fontSize: 14),
                                textAlign: TextAlign.start,
                                initialValue: dataUser["Pass"],
                                onChanged: (val) {
                                  dataUser["Pass"] = val;
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
                                        "${AppLocalizations.of(context)!.translate('password1')}",
                                    hintStyle: TextStyle(
                                        fontFamily: content_font,
                                        color: Colors.grey.shade500,
                                        fontSize: 14)),
                              )),
                          /*  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontFamily: content_font, fontSize: 14),
                      textAlign: TextAlign.start,
                      onChanged: (val) {},
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility,
                            size: 16,
                          ),
                          hintText: 'Confirmer mot de passe',
                          hintStyle: TextStyle(
                              fontFamily: content_font,
                              color: Colors.grey.shade500,
                              fontSize: 14)),
                    )),*/
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Wrap(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: blueColor,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50)),
                                      onPressed: () {
                                        /* widget.completpROfile!(
                                  dataUser["Phone"], dataUser["pass"]);*/
                                        setState(() {
                                          this._isLoading = true;
                                        });
                                        AuthService()
                                            .register(dataUser)
                                            .then((value) {
                                          setState(() {
                                            this._isLoading = false;
                                          });
                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.success(
                                              message: value.toString(),
                                            ),
                                          );
                                          /* setState(() {
                                            _isverify = true;
                                          });*/
                                          widget.goToLogin!();
                                        }).catchError((error) {
                                          print(error);
                                          setState(() {
                                            this._isLoading = false;
                                          });
                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.error(
                                              message: error.toString(),
                                            ),
                                          );
                                        });
                                      },
                                      child: Text(
                                        "${AppLocalizations.of(context)!.translate('Valider')}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Text(
                                "${AppLocalizations.of(context)!.translate('condition')}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: content_font,
                                    fontSize: 12,
                                    color: Colors.grey.shade500)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "${AppLocalizations.of(context)!.translate('Lire')}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: content_font,
                                    fontSize: 12,
                                    color: blueColor)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: GestureDetector(
                            onTap: () {
                              widget.goToLogin!();
                            },
                            child: Text(
                                "${AppLocalizations.of(context)!.translate('Jai déjà un compte')}",
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
                Container(
                    child: _isLoading
                        ? Loader(loadingTxt: 'Creation de compte encour ...')
                        : Container())
              ],
            ));
  }
}
