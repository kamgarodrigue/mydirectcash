import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/retrait_amount_selection.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RechargeDirectCash extends StatefulWidget {
  const RechargeDirectCash({Key? key}) : super(key: key);

  @override
  _RechargeDirectCashState createState() => _RechargeDirectCashState();
}

class _RechargeDirectCashState extends State<RechargeDirectCash> {
  String directCashCode = "", codeSecret = "", psw = "";
  Map detail = {"toNumber": "", "directCode": ""};
  PhoneNumber number = PhoneNumber(isoCode: 'CM', phoneNumber: '');
  final TextEditingController _phonecontroller = TextEditingController();

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    context.read<AuthService>().authenticate;
  }

  @override
  void dispose() {
    _phonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final autProvider = context.watch<AuthService>();
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
                    fit: BoxFit.cover),
              ),
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
                        const SizedBox(width: 20),
                        Text(
                            "${AppLocalizations.of(context)!.translate('Recharge via DirectCash')}",
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
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/logo-alliance-transparent.png',
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                setState(() {
                                  detail['directCode'] = value;
                                });
                              },
                              style: const TextStyle(
                                  fontFamily: content_font, fontSize: 16),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      "${AppLocalizations.of(context)!.translate('Saisissez le code DirectCash')}",
                                  hintStyle: const TextStyle(
                                      fontFamily: content_font,
                                      color: Colors.grey,
                                      fontSize: 13))),
                          Divider(
                            height: 1.5,
                            color: blueColor,
                          ),
                        ],
                      )),
                  // Container(
                  //     margin: const EdgeInsets.only(top: 20),
                  //     child: Column(
                  //       children: [
                  //         TextFormField(
                  //           keyboardType: TextInputType.text,
                  //           onChanged: (value) {
                  //             setState(() {
                  //               codeSecret = value;
                  //             });
                  //           },
                  //           style: const TextStyle(
                  //               fontFamily: content_font, fontSize: 13),
                  //           textAlign: TextAlign.start,
                  //           decoration: InputDecoration(
                  //               suffixIcon: const Icon(
                  //                 Icons.visibility,
                  //                 size: 16,
                  //               ),
                  //               hintText:
                  //                   "${AppLocalizations.of(context)!.translate('Saisissez votre code secret')}",
                  //               hintStyle: TextStyle(
                  //                   fontFamily: content_font,
                  //                   color: Colors.grey.shade500,
                  //                   fontSize: 13)),
                  //         ),
                  //         Divider(
                  //           height: 1.5,
                  //           color: blueColor,
                  //         ),
                  //       ],
                  //     )),
                  // Container(
                  //     margin: const EdgeInsets.only(top: 20),
                  //     child: Column(
                  //       children: [
                  //         TextFormField(
                  //           keyboardType: TextInputType.number,
                  //           // initialValue: data.toNumber,
                  //           onChanged: (value) {
                  //             setState(() {
                  //               detail["toNumber"] = value;
                  //             });
                  //           },
                  //           style: const TextStyle(
                  //               fontFamily: content_font, fontSize: 13),
                  //           textAlign: TextAlign.start,
                  //           decoration: InputDecoration(
                  //             border: InputBorder.none,
                  //             hintText: AppLocalizations.of(context)!.translate(
                  //                 "Saisissez le numéro bénéficiaire")!,
                  //             hintStyle: const TextStyle(
                  //                 fontFamily: content_font,
                  //                 color: Colors.grey,
                  //                 fontSize: 13),
                  //           ),
                  //         ),
                  //         Divider(
                  //           height: 1.5,
                  //           color: blueColor,
                  //         ),
                  //       ],
                  //     )),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        setState(() {
                          detail["toNumber"] = number.phoneNumber;
                        });

                        ///  dataUser["Phone"]==number.phoneNumber;
                      },
                      onInputValidated: (bool isValid) {},
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DROPDOWN,
                        setSelectorButtonAsPrefixIcon: true,
                        leadingPadding: 4.0,
                        showFlags: true,
                        useEmoji: true,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: _phonecontroller,
                      formatInput: false,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputDecoration: InputDecoration(
                        labelStyle: const TextStyle(fontSize: 14),
                        labelText: AppLocalizations.of(context)!
                            .translate("Saisissez le numéro bénéficiaire")!,
                      ),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                        setState(
                          () {
                            detail["toNumber"] = number.phoneNumber;
                          },
                        );
                      },
                    ),
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
                                setState(() {
                                  _isLoading = true;
                                });
                                TransactonService()
                                    .getTransferDetails(detail)
                                    .then((value) {
                                  print(value);
                                  print(value['data'][0].toString().length);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (value['data'][0].toString().length > 5) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: RetraitAmountSelection(
                                          data: value["data"][0],
                                        ),
                                      ),
                                    );
                                  } else if (value['data'][0].toString().length < 5) {
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      const CustomSnackBar.info(
                                        message: "Aucune transaction en attente!",
                                      ),
                                    );
                                  } else {
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.success(
                                        message: value["message"],
                                      ),
                                    );
                                  }

                                  // showTopSnackBar(
                                  //   Overlay.of(context),
                                  //   CustomSnackBar.success(
                                  //     message: value["message"],
                                  //   ),
                                  // );
                                  // Navigator.pop(context);
                                }).catchError((error) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  print(error);
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.error(
                                        message: "une erreur c est produite"),
                                  );
                                });
                                /*showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SuccessOperationComponent();
                                });*/
                              },
                              child: Text(
                                "${AppLocalizations.of(context)!.translate('Valider')}",
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
                            "${AppLocalizations.of(context)!.translate("annuler")}",
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
