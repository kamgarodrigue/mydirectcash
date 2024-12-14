import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Epargne/epargne_marchant_montant.dart';
import 'package:mydirectcash/screens/QRViewExample.dart';
import 'package:mydirectcash/screens/home%20copy.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/payement_marchant_montant.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Microfinance.dart';
import 'package:page_transition/page_transition.dart';


class Epargne extends StatefulWidget {
  const Epargne({Key? key}) : super(key: key);

  @override
  _PayementMarchandState createState() => _PayementMarchandState();
}

class _PayementMarchandState extends State<Epargne> {
  Map data = {
    "pass": "",
    "Montant": "",
    "Client": "",
    "Collecteur": "",
    "frais": "500",
    "Caisse":""
  };
  dynamic microfi=null;
List bannk=[{
  "name":"Afriland First Bank ",
  "image":"assets/images/afriland.jpeg",
  "description":""},
  {
  "name":"Bange Bank",
  "image":"assets/images/bangebank.png",
  "description":""},
   {
  "name":"CCA Bank",
  "image":"assets/images/cca.jpeg",
  "description":""}
  
  
  ];
  Future scan() async {
    setState(() {
      isCanning = true;
    });
  }

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
        ? QRViewExample(
            getCode: setCode,
          )
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
                        SizedBox(width: 40),
                        
                        Text(
                            AppLocalizations.of(context)!
                                .translate("Epargné Mon argent")!,
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
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        onTap: () {
                           showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child:  ListView(
                    padding: EdgeInsets.only(top: 32),
                    children:List.generate(bannk.length, (index) => Microfinance(image: bannk[index]["image"], name: bannk[index]["name"], slogant: "",ontap:() {
                   setState(() {
                      microfi=bannk[index];
                   });
                   print("lest te[p]");
                   Navigator.pop(context);
                    }),),
                  
               ) );
              });
                        },
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        initialValue: data["Caisse"],
                        onChanged: (value) {
                          setState(() {
                            data["Caisse"] = value;
                          });
                        },
                        style:
                            TextStyle(fontFamily: content_font, fontSize: 13),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                           // suffixIcon: IconButton(
                               // onPressed: () => scan(),
                               // icon: Icon(Icons.qr_code_scanner,
                                  //  size: 17, color: Colors.blue)),
                            hintText: data["Caisse"] == ""
                                ? AppLocalizations.of(context)!
                                    .translate("Choisir mon partenaire")!
                                : data["Caisse"],
                            hintStyle: TextStyle(
                                fontFamily: content_font,
                                color: Colors.grey.shade500,
                                fontSize: 13)),
                      )),
                                        SizedBox(
                    height: 20,
                  ),
                  if(microfi!=null)
                Microfinance(image: microfi["image"], name: microfi["name"], slogant: "",ontap: () {
                  
                },),
                  SizedBox(height: 50),
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
                                      EdgeInsets.symmetric(horizontal: 50)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: EpargneMarchandMontant(
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
                    onTap: () async {
                    //  scan();
//scanQRCode();
      

   
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

