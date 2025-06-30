import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydirectcash/Models/DetailTransaction.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/app_routes.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EnvoiDirectCashPassword extends StatefulWidget {
  DataTransaction? dataTransaction;
  dynamic context1;
  dynamic context2;
  Map? data;
  EnvoiDirectCashPassword(
      {Key? key,
      @required this.dataTransaction,
      this.context1,
      this.data,
      this.context2})
      : super(key: key);

  @override
  _EnvoiDirectCashPasswordState createState() =>
      _EnvoiDirectCashPasswordState();
}

class _EnvoiDirectCashPasswordState extends State<EnvoiDirectCashPassword> {
  bool _isLoading = false;
  bool _isOscure = true;
  bool _isOscure1 = true;

  void togle() {
    setState(() {
      _isOscure = !_isOscure;
    });
  }

  void togle1() {
    setState(() {
      _isOscure1 = !_isOscure1;
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
                        const SizedBox(width: 50),
                        Text(
                            AppLocalizations.of(context)!
                                .translate("Transfert DirectCash")!,
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
      color: Colors.black,
    ),
    children: [
      TextSpan(text: '${AppLocalizations.of(context)!.translate("Vous allez faire un transfert  de")} '),
      TextSpan(
        text: '${widget.data?["vAmount"]} XAF',
        style:  TextStyle(color:blueColor),
      ),
      TextSpan(text: ' ${AppLocalizations.of(context)!.translate("au numéro")} '),
      TextSpan(
        text: '${widget.data?["vToNumber"].toString().substring(0, 3)}',
        style:  TextStyle(color: blueColor),
      ),
      TextSpan(text: ', ${AppLocalizations.of(context)!.translate("frais de")} '),
      TextSpan(
        text: '${widget.data?["vRate"]} XAF',
        style:  TextStyle(color: blueColor),
      ),
      TextSpan(text: '. ${AppLocalizations.of(context)!.translate("Montant total à débiter")} '),
      TextSpan(
        text: '${(double.parse(widget.data?["vRate"]) + double.parse(widget.data?["vAmount"])).toStringAsFixed(2)} XAF',
        style:  TextStyle(color:blueColor),
      ),
      TextSpan(text: '.'),
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
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                          LengthLimitingTextInputFormatter(
                              4), // Limit input to 4 digits
                        ],
                        onChanged: (value) {
                          if (value.length > 4) {
                            return; // Prevents excessive input
                          }
                          setState(() {
                            widget.data?['secret'] = value;
                          });
                        },
                        obscureText: _isOscure1,
                        style: const TextStyle(
                            fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isOscure1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 16,
                            ),
                            onPressed: () => togle1(),
                          ),
                          hintText: AppLocalizations.of(context)!
                              .translate("code secret")!,
                          hintStyle: TextStyle(
                              fontFamily: content_font,
                              color: Colors.grey.shade500,
                              fontSize: 13),
                        ),
                      )),
                  const SizedBox(height: 5),
                  Text(
                    widget.data!['secret'].toString().length < 4
                        ? "le code doit comprendre 4 chiffre"
                        : "",
                    style: const TextStyle(
                        fontFamily: content_font,
                        color: Color.fromARGB(255, 245, 49, 49),
                        fontSize: 12),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        // initialValue: widget.dataTransaction!.pass,
                        onChanged: (value) {
                          setState(() {
                            widget.data?["vPIN"] = value;
                          });
                        },
                        obscureText: _isOscure,
                        style: const TextStyle(
                            fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isOscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 16,
                              ),
                              onPressed: () => togle(),
                            ),
                            hintText: AppLocalizations.of(context)!
                                .translate("Password")!,
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
                                print(widget.data);
                                setState(() {
                                  _isLoading = true;
                                });
                                TransactonService()
                                    .transfertByDirectcash(widget.data)
                                    .then((value) {
                                  print(value);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (value['message'] ==
                                      "Erreur interne du serveur lors de l'appel de la procédure stockée.") {
                                    DialogWidget.success(
                                      context,
                                      title: AppLocalizations.of(context)!
                                          .translate("erreur")!,
                                      content: value["message"],
                                      color: errorColor,
                                      callback: () {
                                        // Navigator.pop(widget.context1);
                                        // Navigator.pop(widget.context2);
                                        Navigator.pop(context);
                                      },
                                    );
                                  } else if (value["code"] == 200) {
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
                                  } else if (value["message"] ==
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
                                  } 
                                  else if (value["message"] ==
                                      "Solde insuffisant pour effectuer cette transaction.") {
                                    DialogWidget.success(
                                      context,
                                      title: "Erreur",
                                      content: value['message'],
                                      color: errorColor,
                                      callback: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  }
                                  else if (value["code"] == 400) {
                                    DialogWidget.success(
                                      context,
                                      title: "Erreur",
                                      content: value['message'],
                                      color: errorColor,
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
