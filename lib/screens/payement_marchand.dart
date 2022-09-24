import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/QRViewExample.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/payement_marchant_montant.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';

class PayementMarchand extends StatefulWidget {
  const PayementMarchand({Key? key}) : super(key: key);

  @override
  _PayementMarchandState createState() => _PayementMarchandState();
}

class _PayementMarchandState extends State<PayementMarchand> {
  Map data = {
    "pass": "",
    "Montant": "",
    "Client": "",
    "Collecteur": "",
    "frais": ""
  };
  bool isCanning = false;
  void setCode(String code) {
    print(code);
    setState(() {
      data["Client"] = code;
      isCanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(data["Client"]);
    print("test + $isCanning ");
    return isCanning
        ? QRViewExample(getCode: setCode)
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Container(
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
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: data["Client"],
                        onChanged: (value) {
                          setState(() {
                            data["Client"] = value;
                          });
                        },
                        style:
                            TextStyle(fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: QRViewExample(
                                            getCode: setCode,
                                          )));
                                },
                                icon: Icon(Icons.qr_code_scanner,
                                    size: 17, color: Colors.blue)),
                            hintText: data["Client"] == ""
                                ? AppLocalizations.of(context)!
                                    .translate("Entrez le code de la caisse")!
                                : data["Client"],
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
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: PayementMarchandMontant(
                                          data: data,
                                        )));
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("suivant")!,
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
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 1.5,
                          color: Colors.grey.shade700,
                        )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                              AppLocalizations.of(context)!.translate("ou")!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: content_font,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        Expanded(
                            child: Container(
                          height: 1.5,
                          color: Colors.grey.shade700,
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: QRViewExample(
                                getCode: setCode,
                              )));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.indigo.withOpacity(0.2),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.qr_code_2_outlined,
                            size: 100,
                          ),
                          Text(
                              AppLocalizations.of(context)!.translate(
                                  "Scannez le QR Code de la caisse")!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: content_font,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
