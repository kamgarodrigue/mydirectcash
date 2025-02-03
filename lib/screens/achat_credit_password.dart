import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AchatCreditPassword extends StatefulWidget {
  Map? data;
  dynamic parentcontext;
  AchatCreditPassword({Key? key, this.data, this.parentcontext})
      : super(key: key);

  @override
  _AchatCreditPasswordState createState() => _AchatCreditPasswordState();
}

class _AchatCreditPasswordState extends State<AchatCreditPassword> {
  bool _isLoading = false;
  bool _isOscure = true;
  void togle() {
    setState(() {
      _isOscure = !_isOscure;
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
                  Row(
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
                  const SizedBox(
                    height: 20,
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
                            ' ${AppLocalizations.of(context)!.translate('Vous allez faire une recharge de')} ${widget.data!["montant"]} XAF  ${AppLocalizations.of(context)!.translate('au numéro')}  ${widget.data!["numero"].substring(0, 3)} ** ** ${widget.data?["numero"].toString().substring(widget.data!["numero"].toString().length - 2)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.5,
                                fontFamily: content_font,
                                color: blueColor,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              '${AppLocalizations.of(context)!.translate('Veuillez saisir le mot de passe pour valider la transastion')}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: content_font,
                                  fontWeight: FontWeight.w500)),
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
                        style: const TextStyle(
                            fontFamily: content_font, fontSize: 13),
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
                                _isOscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
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
                                print(widget.data);
                                TransactonService()
                                    .achatCredit(widget.data)
                                    .then((value) {
                                  print("value: $value");
                                  setState(() {
                                    _isLoading = false;
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

                                  DialogWidget.success(context,
                                      title: "Succes !",
                                      content: "crédit envoyé avec succes",
                                      color: greenColor, callback: () {
                                    Navigator.pop(context);
                                    Navigator.pop(widget.parentcontext);
                                  });
                                }).catchError((error) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  print(error);

                                  //  ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //       content: Text(
                                  //           "${AppLocalizations.of(context)!.translate('Saisissez le numéro bénéficiaire')}")),
                                  // );
                                });
                              },
                              child: Text(
                                '${AppLocalizations.of(context)!.translate('Valider')}',
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
                  GestureDetector(
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
                          color: blueColor),
                    ),
                  )
                ],
              ),
            ),
            Container(
                child: _isLoading ? Loader(color: blueColor) : Container())
          ],
        ));
  }
}
