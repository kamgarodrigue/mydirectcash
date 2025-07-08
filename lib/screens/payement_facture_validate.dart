import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/payement_marchant_montant.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PayementFactureValidate extends StatefulWidget {
  PayementFactureValidate({super.key, required this.factureInfos, this.detailFac});
  dynamic factureInfos;
  dynamic detailFac;

  @override
  _PayementFactureValidateState createState() =>
      _PayementFactureValidateState();
}

class _PayementFactureValidateState extends State<PayementFactureValidate> {

  @override
  void initState() {
    super.initState();
    context.read<AuthService>().authenticate;
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    widget.detailFac["frais"] =
        widget.detailFac["frais"] ?? "0";
    widget.detailFac["amount"] = (double.tryParse(widget.detailFac["amount"])! +
            double.tryParse(widget.detailFac["frais"])!)
        .toString();
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
                        const SizedBox(width: 50),
                        Text(
                            AppLocalizations.of(context)!
                                .translate('Payement de facture')
                                .toString(),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/canal_plus.jpg",
                          width: 50,
                        ),
                        const SizedBox(
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
                                  widget.factureInfos['title'],
                                  style: TextStyle(
                                      fontFamily: title_font,
                                      color: blueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  widget.factureInfos['description'],
                                  style: TextStyle(
                                      fontFamily: content_font,
                                      fontSize: 12,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                            widget.factureInfos['title'] == 'Abonnement Canal+'
                                ? AppLocalizations.of(context)!
                                    .translate(
                                        "Vous êtes sur le point d'acheter le bouquet ACCESS pour 3 mois")
                                    .toString()
                                : '${AppLocalizations.of(context)!
                                        .translate("Frais :")}${widget.detailFac["frais"]} XAF ${AppLocalizations.of(context)!
                                        .translate(
                                            "le montant total à débité est de")}${widget.detailFac["amount"]} XAF',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12.5,
                                fontFamily: content_font,
                                color: blueColor,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 10,
                        ),
                        if (widget.factureInfos['title'] != 'Bouquet ACCESS')
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .translate(
                                        "Veuillez saisir le mot de passe pour valider la transastion")
                                    .toString(),
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
                        initialValue: widget.detailFac["numeroDeContrat"],
                        onChanged: (value) {
                          setState(() {
                            widget.detailFac["numeroDeContrat"] = value;
                          });
                        },
                        style:
                            const TextStyle(fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .translate(
                                    "Saisissez votre numéro d'abonnement")
                                .toString(),
                            hintStyle: TextStyle(
                                fontFamily: content_font,
                                color: Colors.grey.shade500,
                                fontSize: 13)),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: widget.detailFac["pass"],
                        onChanged: (value) {
                          setState(() {
                            widget.detailFac["pass"] = value;
                          });
                        },
                        style:
                            const TextStyle(fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.visibility,
                              size: 16,
                            ),
                            hintText: AppLocalizations.of(context)!
                                .translate("Mot de passe DirectCash")
                                .toString(),
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
                                  backgroundColor:  blueColor,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 50)),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                print(widget.detailFac);
                                context
                                    .read<TransactonService>()
                                    .PayementFactureCamwaterEneo(
                                        authService.currentUser!.data!.phone!,
                                        "12344",
                                        widget.detailFac)
                                    .then((value) => {
                                          setState(() {
                                            _isLoading = false;
                                          }),
                                          context
                                              .read<AuthService>()
                                              .loginWithBiometric({
                                            "id": context
                                                .read<AuthService>()
                                                .currentUser!
                                                .data!
                                                .phone
                                          }),
                                          showTopSnackBar(
                                           Overlay.of(context),
                                            CustomSnackBar.success(
                                              message: value['message'],
                                            ),
                                          )
                                        })
                                    .catchError((error) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  print(error);
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message: error.toString(),
                                    ),
                                  );
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("Valider")
                                    .toString(),
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
                            AppLocalizations.of(context)!
                                .translate("annuler")
                                .toString(),
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
