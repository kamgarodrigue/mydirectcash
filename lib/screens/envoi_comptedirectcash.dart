import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/envoi_comptedirectcash_password.dart';

import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EnvoiCompteDirectCash extends StatefulWidget {
  dynamic context2;
  EnvoiCompteDirectCash({Key? key, this.context2}) : super(key: key);

  @override
  _EnvoiCompteDirectCashState createState() => _EnvoiCompteDirectCashState();
}

class _EnvoiCompteDirectCashState extends State<EnvoiCompteDirectCash> {
  String? countryName = '';
  String? operateur = "Choisissez l'opérateur";

  // DataTransaction data = DataTransaction(
  //   amount: "",
  //   cNI: "",
  //   fromNumber: "",
  //   id: "",
  //   pIN: "",
  //   pass: "",
  //   rate: "",
  //   toNumber: "",
  // );

  Map data = {
    "vClientID": "",
    "vAmount": "",
    "vRate": 0.0,
    "vFromNumber": "",
    "vToNumber": "",
    "vCNI": " ",
    "vPIN": "",
    "vrxtype": "",
  };
  Map? param;
  bool _isLoading = false;
  String? _code;
  PhoneNumber number = PhoneNumber(isoCode: 'CM', phoneNumber: '');
  final TextEditingController _phonecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    printUserCountry();
    context.read<AuthService>().authenticate;
  }

  String? country;

  Future<void> printUserCountry() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permission denied');
          Navigator.of(context).pop;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied.');
        Navigator.of(context).pop;
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocode to get country
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        country = placemarks.first.country;
        print("test ${placemarks[3]}");

        print('User is in: $country');
      } else {
        print('Could not determine the country.');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  Future<void> _pickContact() async {
    try {
      // Request permission and pick a contact
      if (await FlutterContacts.requestPermission()) {
        final contact = await FlutterContacts.openExternalPick();
        if (contact != null && contact.phones.isNotEmpty) {
          setState(() {
            String selectedNumber = contact.phones.first.number;
            List<String> parts = selectedNumber.split(' ');
            String phoneWithoutCode =
                parts.length > 1 ? parts.sublist(1).join('') : selectedNumber;
            _phonecontroller.text = phoneWithoutCode;
            data["vToNumber"] = _phonecontroller.text;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              "${AppLocalizations.of(context)!.translate(
                'Saisissez le numéro bénéficiaire',
              )}",
            )),
          );
        }
      } else {
        // Handle permission denied case
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${AppLocalizations.of(context)!.translate(
              'Saisissez le numéro bénéficiaire',
            )}"),
          ),
        );
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick a contact: $e')),
      );
    }
  }

  void setTransactionType() {
    print(country);
    if (country != "Cameroon" && country != "Cameroun") {
      setState(() {
        data['vrxtype'] = "12";
      });
    } else if (number.isoCode != "CM" || _code != "+237") {
      setState(() {
        data['vrxtype'] = "12";
      });
    } else {
      setState(() {
        data['vrxtype'] = "11";
      });
    }
  }

  String codeRegion = "";

  @override
  Widget build(BuildContext context) {
    final autProvider = context.watch<AuthService>();
    //print(country);
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
                        const SizedBox(width: 20),
                        Text(
                            AppLocalizations.of(context)!
                                .translate("Envoi - Compte MyDirectCash")!,
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
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                    countryName == ''
                                        ? AppLocalizations.of(context)!.translate(
                                            "Choisissez le pays de destination")!
                                        : countryName!,
                                    style: TextStyle(
                                        color: countryName == ''
                                            ? Colors.grey
                                            : Colors.black,
                                        fontSize: 14)),
                              ),
                              CountryListPick(
                                  appBar: AppBar(
                                    backgroundColor: blueColor,
                                    title: Text(AppLocalizations.of(context)!
                                        .translate(
                                            "Choisissez le pays de destination")!),
                                  ),
                                  theme: CountryTheme(
                                    isShowFlag: false,
                                    isShowTitle: false,
                                    isShowCode: false,
                                    isDownIcon: true,
                                    showEnglishName: false,
                                  ),
                                  initialSelection: '+237',
                                  onChanged: (CountryCode? code) {
                                    setState(() {
                                      _code = code.toString();
                                      //     ? data["vrxtype"] = "11"
                                      //     : data["vrxtype"] = "12";
                                      countryName = code!.name == null
                                          ? AppLocalizations.of(context)!.translate(
                                              "Choisissez le pays de destination")!
                                          : "${code.name} ($code)";
                                      codeRegion = code.code!;
                                      number = PhoneNumber(isoCode: codeRegion);
                                    });
                                  },
                                  useUiOverlay: true,
                                  useSafeArea: false),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          height: 1.5,
                          color: blueColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        setState(() {
                          _code = number.dialCode.toString();
                        });
                        print(_code);
                        String phoneWithoutCode = number.phoneNumber
                                ?.replaceFirst(number.dialCode ?? '', '') ??
                            '';
                        if (number.isoCode == "CM") {
                          setState(() {
                            data['vToNumber'] = phoneWithoutCode;
                          });
                        } else {
                          setState(() {
                            data['vToNumber'] = phoneWithoutCode;
                          });
                        }
                      },
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Ajoutez un numero !";
                        }
                        if (value.length < 9 || value.length > 14) {
                          return "Numero invalid !";
                        }
                        return null;
                      },
                      onInputValidated: (bool isValid) {
                        print(isValid);
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DROPDOWN,
                        setSelectorButtonAsPrefixIcon: true,
                        leadingPadding: 8.0,
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.perm_contact_calendar_sharp,
                            size: 24,
                            color: blueColor,
                          ),
                          onPressed: _pickContact, // Open contact picker
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blueColor, width: 2),
                        ),
                        hintText:
                            "${AppLocalizations.of(context)!.translate('Phone')}",
                        hintStyle: const TextStyle(
                            fontFamily: content_font,
                            color: Colors.grey,
                            fontSize: 13),
                      ),
                      onSaved: (PhoneNumber number) {
                        String phoneWithoutCode = number.phoneNumber
                                ?.replaceFirst(number.dialCode ?? '', '') ??
                            '';
                        setState(() {
                          data['vToNumber'] = phoneWithoutCode;
                        });
                      },
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(top: 10),
                  //   child: TextFormField(
                  //     keyboardType: TextInputType.number,
                  //     initialValue: data["vToNumber"],
                  //     onChanged: (val) {
                  //       data["vToNumber"] = val;
                  //     },
                  //     validator: (value) {
                  //       if (value!.trim().isEmpty) {
                  //         return "${AppLocalizations.of(context)!.translate('Phone')} *";
                  //       }
                  //     },
                  //     style: const TextStyle(
                  //       fontFamily: content_font,
                  //       fontSize: 14,
                  //     ),
                  //     textAlign: TextAlign.start,
                  //     cursorColor: blueColor,
                  //     decoration: InputDecoration(
                  //         focusedBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: blueColor, width: 2),
                  //         ),
                  //         hintText:
                  //             "${AppLocalizations.of(context)!.translate('Phone')} *",
                  //         hintStyle: TextStyle(
                  //             fontFamily: content_font,
                  //             color: Colors.grey.shade500,
                  //             fontSize: 14)),
                  //   ),
                  // ),

                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.number,
                              // initialValue: data.amount,
                              onChanged: (value) {
                                setState(() {
                                  data['vAmount'] = value;
                                });
                              },
                              style: const TextStyle(
                                  fontFamily: content_font, fontSize: 13),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)!
                                      .translate("Saisire montant")!,
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
                                if (country == null) {
                                  DialogWidget.success(context,
                                      title: "Transaction impossible!",
                                      content:
                                          "veuillez verifier votre connextion internet",
                                      color: blueColor, callback: () {
                                    Navigator.pop(context);
                                  });
                                  return;
                                }
                                setTransactionType();
                                setState(() {
                                  _isLoading = true;
                                  param = {
                                    "amount": data['vAmount'],
                                    "to": data['vToNumber'],
                                    "transactionType": data['vrxtype'],
                                  };
                                });
                                print(param);
                                TransactonService()
                                    .getDetailEnvoiDirectcash(param)
                                    .then((value) {
                                  print(value);
                                  data['vFromNumber'] =
                                      autProvider.currentUser!.data!.phone;
                                  data["vClientID"] =
                                      autProvider.currentUser!.data!.phone;
                                  data["vRate"] = value["data"]["fees"];
                                  if (value['data']['nameReceiver']
                                          .toString()
                                          .length <
                                      4) {
                                    DialogWidget.success(context,
                                        title: "",
                                        content: "Le compte n'existe pas!",
                                        color: blueColor, callback: () {
                                      Navigator.pop(context);
                                    });
                                  } else if (data['vToNumber'] ==
                                      data['vFromNumber']) {
                                    DialogWidget.success(context,
                                        title: "Transaction impossible!",
                                        content:
                                            "veuillez saissir un autre numéro de téléphone",
                                        color: blueColor, callback: () {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child:
                                                EnvoiCompteDirectCashPassword(
                                              data: data,
                                              context1: context,
                                              nom: value['data']
                                                  ['nameReceiver'],
                                              context2: widget.context2,
                                            )));
                                  }

                                  setState(() {
                                    _isLoading = false;
                                  });
                                }).catchError((error) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                                /* */
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
                ],
              ),
            ),
            Container(
                child: _isLoading ? const Loader(loadingTxt: '') : Container())
          ],
        ));
  }
}
