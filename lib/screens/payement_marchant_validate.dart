import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class PayementMarchandValidate extends StatefulWidget {
  Map? data;
  PayementMarchandValidate({Key? key, this.data}) : super(key: key);

  @override
  _PayementMarchandValidateState createState() =>
      _PayementMarchandValidateState();
}

class _PayementMarchandValidateState extends State<PayementMarchandValidate> {
  bool _isLoading = false;
  bool _isOscure = true;
  void togle() {
    setState(() {
      _isOscure = !_isOscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    double parseDouble(dynamic value) {
      if (value == null || value.toString().isEmpty) {
        return 0.0; // Default value if null or empty
      }
      return double.tryParse(value.toString()) ??
          0.0; // Safely parse, fallback to 0.0 if invalid
    }

    double debite = parseDouble(widget.data!["Montant"]) +
        parseDouble(widget.data!["frais"]);

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
                                .translate("Payement marchand")!,
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
                            '${AppLocalizations.of(context)!.translate("Frais :")!} : ${widget.data!["Montant"]} XAF, ${AppLocalizations.of(context)!.translate("le montant total à débité est de")!} $debite XAF',
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
                              AppLocalizations.of(context)!.translate(
                                  "Veuillez saisir le mot de passe pour valider la transastion")!,
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
                        initialValue: "${widget.data!["pass"]}",
                        onChanged: (value) {
                          setState(() {
                            widget.data!["pass"] = value;
                          });
                        },
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
                                .translate("Password"),
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
                                    .payerMarchant(widget.data)
                                    .then((value) {
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
                                      content: value.toString(),
                                      color: greenColor, callback: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                                  // Navigator.pop(context);
                                }).catchError((error) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  print(error);
                                     DialogWidget.error(context,
                                      title: AppLocalizations.of(context)!
                                          .translate("erreur")!,
                                      content: error.toString(),
                                      color: errorColor, callback: () {
                                    Navigator.pop(context);
                                  });
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
                        child: Text("Annuler",
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
