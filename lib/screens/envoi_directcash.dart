import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:mydirectcash/Controllers/UserController.dart';
import 'package:mydirectcash/Models/DetailTransaction.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/achat_credit_password.dart';
import 'package:mydirectcash/screens/envoi_directcash_password.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EnvoiDirectCash extends StatefulWidget {
  dynamic context1;
  EnvoiDirectCash({Key? key, this.context1}) : super(key: key);

  @override
  _EnvoiDirectCashState createState() => _EnvoiDirectCashState();
}

class _EnvoiDirectCashState extends State<EnvoiDirectCash> {
  String? countryName = 'Choisissez le pays de destination';
  String? coupon = 'Choisissez le coupon crédit';
  Contact? _selectedContact;
  TextEditingController _controller = TextEditingController();

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
  bool _isLoading = false;
  String codeRegion = "";
  @override
  void initState() {
    super.initState();
    _controller.text = "";
    context.read<AuthService>().authenticate;
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
            // Update the text field and the data map with the selected phone number
            String selectedNumber = contact.phones.first.number;
            _controller.text = selectedNumber;
            dataTransaction.toNumber = selectedNumber;
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
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('$countryName',
                                    style: TextStyle(
                                        color: countryName ==
                                                AppLocalizations.of(context)!
                                                    .translate(
                                                        "Choisissez le pays de destination")!
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
                                    isShowFlag: true,
                                    isShowTitle: false,
                                    isShowCode: false,
                                    isDownIcon: true,
                                    showEnglishName: false,
                                  ),
                                  initialSelection: '+237',
                                  onChanged: (CountryCode? code) {
                                    setState(() {
                                      countryName = code!.name == null
                                          ? AppLocalizations.of(context)!.translate(
                                              "Choisissez le pays de destination")!
                                          : "${code.name} ($code)";
                                    });
                                    print(code!.name);
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
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                    
                          TextFormField(
                            controller:
                                _controller, // Use the controller to manage the text field
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            onChanged: (value) {
                              setState(() {
                                dataTransaction.toNumber =
                                    value; // Update the data map when the text changes
                              });
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon:  Icon(
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
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: dataTransaction.amount,
                              onChanged: (value) {
                                setState(() {
                                  dataTransaction.amount = value;
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
                                print(autProvider.currentUser!.data!.phone);
                                setState(() {
                                  _isLoading = true;
                                });

                                context
                                    .read<TransactonService>()
                                    .getDetailEnvoiDirectcash(
                                        dataTransaction.toNumber,
                                        dataTransaction.amount)
                                    .then((value) {
                                  print(value);
                                  dataTransaction.fromNumber =
                                      autProvider.currentUser!.data!.phone;
                                  dataTransaction.id =
                                      autProvider.currentUser!.data!.phone;
                                  dataTransaction.rate =
                                      json.decode(value.toString())["rate"];
                                  print(dataTransaction.toJson());
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: EnvoiDirectCashPassword(
                                            context1: widget.context1,
                                            context2: context,
                                            dataTransaction: dataTransaction,
                                            detail:
                                                json.decode(value.toString()),
                                          )));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }).catchError((error) {
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
                child: _isLoading
                    ? Loader(loadingTxt: 'Content is loading...')
                    : Container())
          ],
        ));
  }
}
