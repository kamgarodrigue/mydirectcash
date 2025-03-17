import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';

class RetraitValidation extends StatefulWidget {
  Map? retrait;
  RetraitValidation({
    Key? key,
    this.retrait,
  }) : super(key: key);

  @override
  _RetraitValidationState createState() => _RetraitValidationState();
}

class _RetraitValidationState extends State<RetraitValidation> {
  bool _isLoading = false;
  bool _isOscure = true;
  bool _isOscure2 = true;

  void togle() {
    setState(() {
      _isOscure = !_isOscure;
    });
  }
  void togle2() {
    setState(() {
      _isOscure2 = !_isOscure2;
    });
  }

  Map data = {
    "vClientID": "",
    "vPIN": "",
    "vTO_NUMBER": "",
    "vTRXID": "",
    "secret": "",
  };

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
                                .translate("Recharge via DirectCash")!,
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
                        Text(
                          '${AppLocalizations.of(context)!.translate("Vous allez faire une recharge de")} '
                          '${widget.retrait?["Amount"]} XAF '
                          '${AppLocalizations.of(context)!.translate("au numéro")} '
                          '${widget.retrait?["ToNumber"].toString().substring(0, 4)} ** ** '
                          '${widget.retrait?["ToNumber"].toString().substring(widget.retrait!["ToNumber"].toString().length - 2)}, '
                          '${AppLocalizations.of(context)!.translate("frais de")} '
                          '${widget.retrait?["Rate"]} XAF. '
                          '${AppLocalizations.of(context)!.translate("Montant total à débiter")} '
                          '${double.parse(widget.retrait!["Amount"].toString())} XAF.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12.5,
                              fontFamily: content_font,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
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
                            data["secret"] = value;
                          });
                        },
                        obscureText: _isOscure2,
                        style: const TextStyle(
                            fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isOscure2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 16,
                              ),
                              onPressed: () => togle2(),
                            ),
                            hintText: AppLocalizations.of(context)!
                                .translate("code secret")!,
                            hintStyle: TextStyle(
                                fontFamily: content_font,
                                color: Colors.grey.shade500,
                                fontSize: 13)),
                      )),
                  const SizedBox(height: 10),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        // initialValue: widget.dataTransaction!.pass,
                        onChanged: (value) {
                          setState(() {
                            data["vPIN"] = value;
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
                                setState(() {
                                  data["vTRXID"] =
                                      widget.retrait?["TransferID"];
                                  data["vClientID"] =
                                      widget.retrait?["AgentID"];
                                  data["vTO_NUMBER"] =
                                      widget.retrait?["ToNumber"];
                                  _isLoading = true;
                                });
                                print(data);
                                TransactonService()
                                    .retraitDirectcash(data)
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
                                        if (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                          if (Navigator.canPop(context)) {
                                            Navigator.pop(context);
                                          }
                                        }
                                      },
                                    );
                                  } else if (value["code"] == 200) {
                                    DialogWidget.success(
                                      context,
                                      title: "",
                                      content: value['data']['message'],
                                      color: greenColor,
                                      callback: () {
                                       if (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                          if (Navigator.canPop(context)) {
                                            Navigator.pop(context);
                                          }
                                        }
                                      },
                                    );
                                  } else if (value["code"] == 400) {
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
                child: _isLoading ? const Loader(loadingTxt: '') : Container())
          ],
        ));
  }
}
