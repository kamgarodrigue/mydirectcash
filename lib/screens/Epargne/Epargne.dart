import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/OperationServices.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Epargne/epargne_marchant_montant.dart';
import 'package:mydirectcash/screens/QRViewExample.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:mydirectcash/widgets/Microfinance.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Epargne extends StatefulWidget {
  const Epargne({Key? key}) : super(key: key);

  @override
  _PayementMarchandState createState() => _PayementMarchandState();
}

class _PayementMarchandState extends State<Epargne> {
  Map data = {
    "vClientID": "",
    "vMerchantCode": "",
    "vToAgentId": "",
    "vAmount": 0,
    "vFromNumber": "",
    "vToNumber": "",
    "vCNI": " ",
    "vPIN": "",
    "vTRX_Type": 9,
  };

  String? agentName;

  dynamic microfi;
  // List bannk = [
  //   {
  //     "name": "Afriland First Bank ",
  //     "image": "assets/images/afriland.jpeg",
  //     "description": ""
  //   },
  //   {
  //     "name": "Bange Bank",
  //     "image": "assets/images/bangebank.png",
  //     "description": ""
  //   },
  //   {"name": "CCA Bank", "image": "assets/images/cca.jpeg", "description": ""}
  // ];

  bool _isLoading = false;

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
                                                type: PageTransitionType
                                                    .rightToLeft,
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
                            const SizedBox(width: 40),
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
                          margin: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: data["vMerchantCode"],
                            onChanged: (value) {
                              setState(() {
                                data["vMerchantCode"] = value;
                              });
                            },
                            style: const TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                // suffixIcon: IconButton(
                                // onPressed: () => scan(),
                                // icon: Icon(Icons.qr_code_scanner,
                                //  size: 17, color: Colors.blue)),
                                hintText: data["vMerchantCode"] == ""
                                    ? AppLocalizations.of(context)!.translate(
                                        "Entrez le code de la caisse")!
                                    : data["vMerchantCode"],
                                hintStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey.shade500,
                                    fontSize: 13)),
                          )),
                      const SizedBox(height: 5),
                      Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                _isLoading = true;
                              });

                              OperationServices().getBank().then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                List<dynamic> agents = value['data'];
                                print(agents);
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ListView(
                                        padding: const EdgeInsets.only(top: 32),
                                        children: List.generate(
                                          agents.length,
                                          (index) => Microfinance(
                                              image:
                                                  "https://apibackoffice.alliancefinancialsa.com/${agents[index]["photo"]}",
                                              name: agents[index]["AgentName"],
                                              slogant: "",
                                              ontap: () {
                                                setState(() {
                                                  microfi = agents[index];
                                                  data['vClientID'] = context
                                                      .read<AuthService>()
                                                      .currentUser!
                                                      .data!
                                                      .phone;
                                                  data['vFromNumber'] = context
                                                      .read<AuthService>()
                                                      .currentUser!
                                                      .data!
                                                      .phone;
                                                  data['vToNumber'] =
                                                      agents[index]['Phone'];
                                                  data['vToAgentId'] =
                                                      agents[index]['Agent_ID'];

                                                  agentName = agents[index]
                                                      ['AgentName'];
                                                });
                                                print(data);
                                                print(agentName);
                                                Navigator.pop(context);
                                              }),
                                        ),
                                      );
                                    });
                              });
                            },
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                // suffixIcon: IconButton(
                                // onPressed: () => scan(),
                                // icon: Icon(Icons.qr_code_scanner,
                                //  size: 17, color: Colors.blue)),
                                hintText: AppLocalizations.of(context)!
                                    .translate("Choisir mon partenaire")!,
                                hintStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey.shade500,
                                    fontSize: 13)),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      if (microfi != null)
                        Microfinance(
                          image:
                              "https://apibackoffice.alliancefinancialsa.com/${microfi["photo"]}",
                          name: microfi["AgentName"],
                          slogant: "",
                          ontap: () {},
                        ),
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
                                    if (data["vMerchantCode"] == "" ||
                                        agentName == null) {
                                      DialogWidget.error(
                                        context,
                                        title: "",
                                        content: AppLocalizations.of(context)!
                                            .translate('veille'),
                                        color: blueColor,
                                        callback: () => Navigator.pop(context),
                                      );
                                    } else {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: EpargneMarchandMontant(
                                                data: data,
                                                agentName: agentName,
                                              )));
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .translate("suivant")!,
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
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 1.5,
                              color: Colors.grey.shade700,
                            )),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .translate("ou")!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () async {
                          //  scan();
                          //scanQRCode();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.indigo.withOpacity(0.2),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.qr_code_2_outlined,
                                size: 100,
                              ),
                              Text(
                                  AppLocalizations.of(context)!.translate(
                                      "Scannez le QR Code de la caisse")!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
                ),
                // Container(
                //     child: _isLoading
                //         ? Loader(
                //             color: blueColor,
                //             loadingTxt:
                //                 "${AppLocalizations.of(context)!.translate('loaderconex')}")
                //         : Container())
              ],
            ));
  }
}
