import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mydirectcash/Models/DetailTransaction.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/envoi_directcash_password.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EnvoiDirectCash extends StatefulWidget {
  dynamic context1;
  Map? data;
  EnvoiDirectCash({Key? key, this.context1, this.data}) : super(key: key);

  @override
  _EnvoiDirectCashState createState() => _EnvoiDirectCashState();
}

class _EnvoiDirectCashState extends State<EnvoiDirectCash> {
  String? countryName = 'Choisissez le pays de destination';
  String? coupon = 'Choisissez le coupon crédit';
  final TextEditingController _controller = TextEditingController();

  PhoneNumber number = PhoneNumber(isoCode: 'CM', phoneNumber: '');

  DataTransaction dataTransaction = DataTransaction(
    amount: "",
    cNI: "",
    fromNumber: "",
    id: "",
    pIN: "",
    pass: "",
    rate: "",
    toNumber: "",
  );
  String? _code;
  Map? param;
  bool _isLoading = false;
  String codeRegion = "";
  String? country;
  @override
  void initState() {
    super.initState();
    printUserCountry();
    _controller.text = "";
    data['vrxtype'] = "1";
    context.read<AuthService>().authenticate;
  }

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
        print('User is in: $country');
      } else {
        print('Could not determine the country.');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  void setTransactionType() {
    print(country);
    if (country != "Cameroon") {
      setState(() {
        data['vrxtype'] = "2";
      });
    } else if (number.isoCode != "CM" || _code != "+237") {
      setState(() {
        data['vrxtype'] = "2";
      });
    } else {
      setState(() {
        data['vrxtype'] = "1";
      });
    }
  }

  Map data = {
    "vClientID": "",
    "vAmount": "",
    "vRate": 0.0,
    "vFromNumber": "",
    "vToNumber": "",
    "vCNI": " ",
    "vPIN": "",
    "vrxtype": "",
    "secret": "",
  };

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            _controller.text = phoneWithoutCode;
            data["vToNumber"] = _controller.text;
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

  @override
  Widget build(BuildContext context) {
    final autProvider = context.watch<AuthService>();
    //print(country);
    print(data['vrxtype']);
    print(number.isoCode);
    print(_code);
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
                                .translate("Transfert DirectCash")!,
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
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        _code = number.dialCode.toString();
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
                      textFieldController: _controller,
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
                        _code = number.dialCode.toString();
                        print(_code);
                        String phoneWithoutCode = number.phoneNumber
                                ?.replaceFirst(number.dialCode ?? '', '') ??
                            '';
                        setState(() {
                          data['vToNumber'] = phoneWithoutCode;
                        });
                      },
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            // initialValue:  widget.data?['vAmount'] == 0 ? "" ,
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
                                  fontSize: 13),
                            ),
                          ),
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
                                    "to": _controller.text,
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
                                  print(data);
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: EnvoiDirectCashPassword(
                                            context1: widget.context1,
                                            context2: context,
                                            dataTransaction: dataTransaction,
                                            data: data,
                                          )));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }).catchError((error) {
                                  print(error);
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message: AppLocalizations.of(context)!
                                          .translate("erreur")!,
                                    ),
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("suivant")
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
                ],
              ),
            ),
            Container(
                child: _isLoading ? const Loader(loadingTxt: '') : Container())
          ],
        ));
  }
}
