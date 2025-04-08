import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class OmMoMo extends StatefulWidget {
  const OmMoMo({super.key});

  @override
  _OmMoMoState createState() => _OmMoMoState();
}

class _OmMoMoState extends State<OmMoMo> {
  Map data = {
    "vClientID": "",
    "vAmount": "",
    "vToNumber": "",
    "vCNI": " ",
    "vPIN": "",
    "vreseau": "OM",
    "opType": "depot"
  };
  bool isOm = true, _isLoading = false;
  bool isDepot = false;
  bool _isOscure = true;
  TextEditingController _controller = TextEditingController();
  void togle() {
    setState(() {
      _isOscure = !_isOscure;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthService>().authenticate;
    _controller.text = "";
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is removed
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
            data["vToNumber"] = phoneWithoutCode.toString();
          });
        } else {
          // Show a message if the contact doesn't have a phone number
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "${AppLocalizations.of(context)!.translate('Saisissez le numéro bénéficiaire')}")),
          );
        }
      } else {
        // Handle permission denied case
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "${AppLocalizations.of(context)!.translate('Saisissez le numéro bénéficiaire')}")),
        );
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick a contact: $e')),
      );
    }
  }

  Widget depot() {
    final autProvider = context.watch<AuthService>();
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                  controller:
                      _controller, // Use the controller to manage the text field
                  keyboardType: TextInputType.number,
                  style:
                      const TextStyle(fontFamily: content_font, fontSize: 13),
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    setState(() {
                      data["vToNumber"] = value;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.perm_contact_calendar_sharp,
                        size: 24,
                        color: blueColor,
                      ),
                      onPressed: _pickContact, // Open contact picker
                    ),
                    border: InputBorder.none,
                    hintText:
                        "${AppLocalizations.of(context)!.translate('Saisissez le numéro bénéficiaire')}",
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
        Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.number,
                    // initialValue: data["vAmount"],
                    onChanged: (value) {
                      setState(() {
                        data["vAmount"] = value;
                      });
                    },
                    style:
                        const TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!
                            .translate('Saisire montant'),
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
        Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.number,
                    obscureText: _isOscure,
                    // initialValue: data["vPIN"],
                    onChanged: (value) {
                      setState(() {
                        data["vPIN"] = value;
                      });
                    },
                    style:
                        const TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.visibility,
                            size: 16,
                          ),
                          onPressed: () => togle(),
                        ),
                        border: InputBorder.none,
                        hintText:
                            AppLocalizations.of(context)!.translate('Password'),
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
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        padding: const EdgeInsets.symmetric(horizontal: 50)),
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      data["vClientID"] = autProvider.currentUser!.data!.phone;
                      print(data);
                      TransactonService().achatCredit(data).then((value) {
                        print(value);
                        setState(() {
                          _isLoading = false;
                        });
                        if (value["message"] ==
                            "Tous les paramètres sont requis.") {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: AppLocalizations.of(context)!
                                  .translate("veille")!,
                            ),
                          );
                        } else if (value["code"] == 200) {
                          DialogWidget.success(
                            context,
                            title: value["message"],
                            content: "",
                            color: greenColor,
                            callback: () => Navigator.pop(context),
                          );
                        } else if (value["code"] == 400) {
                          DialogWidget.success(
                            context,
                            title: value["message"],
                            content: "",
                            color: errorColor,
                            callback: () => Navigator.pop(context),
                          );
                        }
                      }).catchError((error) {
                        setState(() {
                          _isLoading = false;
                        });
                        print(error);
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: AppLocalizations.of(context)!
                                .translate("erreur")!,
                          ),
                        );
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('Valider')
                          .toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget retrait() {
    final autProvider = context.watch<AuthService>();
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.number,
                    // initialValue: autProvider.currentUser!.data!.phone,
                    onChanged: (value) {
                      setState(() {
                        data["vToNumber"] = value;
                      });
                    },
                    style:
                        const TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!
                            .translate('Numero du compte')
                            .toString(),
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
        Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.number,
                    // initialValue: data["vAmount"],
                    onChanged: (value) {
                      setState(() {
                        data["vAmount"] = value;
                      });
                    },
                    style:
                        const TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!
                            .translate('Saisire montant')
                            .toString(),
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
        Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.number,
                    obscureText: _isOscure,
                    // initialValue: data["pass"],
                    onChanged: (value) {
                      setState(() {
                        data["vPIN"] = value;
                      });
                    },
                    style:
                        const TextStyle(fontFamily: content_font, fontSize: 13),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.visibility,
                            size: 16,
                          ),
                          onPressed: () => togle(),
                        ),
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!
                            .translate('Password')
                            .toString(),
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
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        padding: const EdgeInsets.symmetric(horizontal: 50)),
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      data["vClientID"] = autProvider.currentUser!.data!.phone;
                      TransactonService().achatCredit(data).then((value) {
                        print(data);
                        print(value);
                        setState(() {
                          _isLoading = false;
                        });
                        if (value["message"] ==
                            "Tous les paramètres sont requis.") {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: AppLocalizations.of(context)!
                                  .translate("veille")!,
                            ),
                          );
                        } else if (value["code"] == 200) {
                          DialogWidget.success(
                            context,
                            title: value["message"],
                            content: "",
                            color: greenColor,
                            callback: () => Navigator.pop(context),
                          );
                        } else if (value["code"] == 400) {
                          DialogWidget.success(
                            context,
                            title: value["message"],
                            content: "",
                            color: errorColor,
                            callback: () => Navigator.pop(context),
                          );
                        }
                      }).catchError((error) {
                        setState(() {
                          _isLoading = false;
                        });
                        print(error);
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: AppLocalizations.of(context)!
                                .translate("erreur")!,
                          ),
                        );
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('Valider')
                          .toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
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
                      padding: const EdgeInsets.symmetric(horizontal: 25),
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
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
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
                          Text('OM / MoMo',
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
                      width: 90,
                      height: 90,
                      child: Image.asset(
                        'assets/images/logo-alliance-transparent.png',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .translate('Chose operator')
                          .toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: title_font,
                          color: blueColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isOm = true;
                                    data["vreseau"] = "OM";
                                  });
                                  print(data["vreseau"]);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: isOm ? 5 : 0,
                                            color: Colors.blueAccent),
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/orange-money.png'),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isOm = false;
                                    data["vreseau"] = "MOMO";
                                  });
                                  print(data["vreseau"]);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: !isOm ? 5 : 0,
                                            color: Colors.blueAccent),
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/mobile-money.png'),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            isOm
                                ? 'assets/images/orange_money.jpeg'
                                : 'assets/images/mobile_money.png',
                            width: 60,
                            height: 60,
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
                                    AppLocalizations.of(context)!
                                        .translate(
                                            'Choisissez le type de transaction')
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: title_font,
                                        color: blueColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .translate('Dépôt')
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          content_font)),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Radio(
                                                    value: isDepot,
                                                    activeColor: blueColor,
                                                    groupValue: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        isDepot = true;
                                                        data["opType"] =
                                                            "depot";
                                                      });
                                                      print(data["opType"]);
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .translate('Retrait')
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          content_font)),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Radio(
                                                    activeColor: blueColor,
                                                    value: !isDepot,
                                                    groupValue: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        isDepot = false;
                                                        data["opType"] =
                                                            "cashout";
                                                      });
                                                      print(data["opType"]);
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    isDepot ? depot() : retrait(),
                  ],
                )),
            Container(child: _isLoading ? Loader(loadingTxt: '') : Container())
          ],
        ));
  }
}
