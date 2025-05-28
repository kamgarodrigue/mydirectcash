import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/OperationServices.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/QRViewExample.dart';
import 'package:mydirectcash/screens/payement_marchant_validate.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/qr_code_scanner.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PayementMarchand extends StatefulWidget {
  const PayementMarchand({Key? key}) : super(key: key);

  @override
  _PayementMarchandState createState() => _PayementMarchandState();
}

class _PayementMarchandState extends State<PayementMarchand> {
  Map data = {
    "vClientID": "",
    "vMerchantCode": "",
    "vToAgentId": "",
    "vAmount": 0,
    "vFromNumber": "",
    "vToNumber": "",
    "vCNI": " ",
    "vPIN": "",
    "vTRX_Type": 10,
  };

  String? agentName;
  TextEditingController _controller = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'CM', phoneNumber: '');

  Future scan() async {
    setState(() {
      isCanning = true;
    });
  }

  bool _isLoading = false;
  bool isCanning = false;
  void setCode(String code) {
    print(code);
    setState(() {
      data["vToNumber"] = code;
      isCanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(data["vToNumber"]);
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
                                fontFamily: content_font, fontSize: 14),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                // suffixIcon: IconButton(
                                // onPressed: () => scan(),
                                // icon: Icon(Icons.qr_code_scanner,
                                //  size: 17, color: Colors.blue)),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: blueColor,
                                    width: 2,
                                  ),
                                ),
                                hintText: data["vMerchantCode"] == ""
                                    ? AppLocalizations.of(context)!.translate(
                                        "Entrez le code de la caisse")!
                                    : data["vMerchantCode"],
                                hintStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey.shade500,
                                    fontSize: 14)),
                          )),
                      const SizedBox(height: 5),
                      // Padding(
                      //   padding: const EdgeInsets.all(0),
                      //   child: InternationalPhoneNumberInput(
                      //     onInputChanged: (PhoneNumber number) {
                      //       print(number.phoneNumber);
                      //       setState(() {
                      //         data["vToNumber"] = number.phoneNumber;
                      //       });
                      //     },
                      //     onInputValidated: (bool isValid) {
                      //       print(isValid);
                      //     },
                      //     selectorConfig: const SelectorConfig(
                      //       selectorType: PhoneInputSelectorType.DROPDOWN,
                      //       setSelectorButtonAsPrefixIcon: true,
                      //       leadingPadding: 0.0,
                      //       showFlags: false,
                      //       useEmoji: true,
                      //     ),
                      //     ignoreBlank: false,
                      //     autoValidateMode: AutovalidateMode.disabled,
                      //     selectorTextStyle:
                      //         const TextStyle(color: Colors.black),
                      //     initialValue: number,
                      //     textFieldController: _controller,
                      //     formatInput: false,
                      //     keyboardType: const TextInputType.numberWithOptions(
                      //         signed: true, decimal: true),
                      //     inputDecoration: InputDecoration(
                      //       focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: blueColor,
                      //           width: 2,
                      //         ),
                      //       ),
                      //       hintText:
                      //           "${AppLocalizations.of(context)!.translate('Phone')}",
                      //       hintStyle: TextStyle(
                      //           fontFamily: content_font,
                      //           color: Colors.grey.shade500,
                      //           fontSize: 14),
                      //     ),
                      //     onSaved: (PhoneNumber number) {
                      //       print('On Saved: $number');
                      //       setState(
                      //         () {
                      //           data["vToNumber"] = number.phoneNumber;
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),

                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                data["vToNumber"] = value;
                              });
                            },
                            style: const TextStyle(
                                fontFamily: content_font, fontSize: 14),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: blueColor,
                                    width: 2,
                                  ),
                                ),
                                hintText:
                                    "${AppLocalizations.of(context)!.translate('Phone')}",
                                hintStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey.shade500,
                                    fontSize: 14)),
                          )),
                      const SizedBox(height: 5),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                               data["vAmount"] = value;
                              });
                            },
                            style: const TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: blueColor,
                                    width: 2,
                                  ),
                                ),
                                hintText: data["vAmount"] == 0
                                    ? AppLocalizations.of(context)!
                                        .translate("Saisire montant")!
                                    : "${data["vAmount"]}",
                                hintStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey.shade500,
                                    fontSize: 13)),
                          )),
                      const SizedBox(height: 40),
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
                                    if (data["vToNumber"] == "" ||
                                        int.parse(data["vAmount"]) < 50 ||
                                        data["vMerchantCode"] == "") {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.error(
                                          message: AppLocalizations.of(context)!
                                              .translate("veille")!,
                                        ),
                                      );
                                      return;
                                    }
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    print("-----------debur");
                                    print(data["vToNumber"]);
                                    print(data["vAmount"]);
                                    print(data["vMerchantCode"]);
print("-----------fin");
                                    Provider.of<OperationServices>(context,
                                            listen: false)
                                        .getAgentByPhone(data["vToNumber"])
                                        .then((value) {
                                      if (value['message'] ==
                                          "Agent récupéré avec succès.") {
                                        setState(() {
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
                                          data['vToAgentId'] =
                                              value['data']['Agent_ID'];

                                          agentName =
                                              value['data']['AgentName'];

                                          _isLoading = false;
                                        });
                                        print(data);
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: PayementMarchandValidate(
                                                  data: data,
                                                  agentName: agentName,
                                                )));
                                      } else {
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          CustomSnackBar.error(
                                            message: value['message'],
                                          ),
                                        );
                                      }
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }).catchError((error) {
                                      print(" hmmmmm $error");
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message: "Erreur interne",
                                        ),
                                      );
                                    });
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
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const QrCodeScanner(),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              data["vMerchantCode"] = result.toString();
                            });
                          }
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
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: _isLoading
                        ? Loader(
                            color: blueColor,
                            loadingTxt:
                                "${AppLocalizations.of(context)!.translate('loaderconex')}")
                        : Container())
              ],
            ));
  }
}
