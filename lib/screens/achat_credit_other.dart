import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/achat_credit_password.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mydirectcash/Controllers/UserController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mydirectcash/Models/User.dart';

class AchatCreditauther extends StatefulWidget {
  Map data;
  AchatCreditauther({Key? key, required this.data}) : super(key: key);

  @override
  _AchatCreditState createState() => _AchatCreditState();
}

class _AchatCreditState extends StateMVC<AchatCreditauther> {
  final bool _isLoading = false;
  _AchatCreditState() : super(UserController()) {
    _userController = UserController.userController;
    _userController!.utilisateur!.then((value) {
      currrentUser = value;
      widget.data["Id"] = value.data!.phone;
    });
  }
  UserController? _userController;
  User? currrentUser;
  String? countryName = "";
  String? coupon = "";
  String? codeRegion = "CM";
  Contact? _selectedContact;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = "";
    print(widget.data);
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
            widget.data?["numero"] = selectedNumber;
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
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(children: [
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
                                          type: PageTransitionType.rightToLeft,
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
                Row(
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
                        "${AppLocalizations.of(context)!.translate('Achat de crédit')}-${widget.data["reseau"] ?? AppLocalizations.of(context)!.translate('network')}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: title_font,
                            color: blueColor,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(
                  height: 20,
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
                    margin: const EdgeInsets.only(top: 20),
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${AppLocalizations.of(context)!.translate('networkSelect')}"),
                                  const SizedBox(width: 10),
                                  PopupMenuButton(
                                    itemBuilder: (context) => [
                                      {
                                        'title': "CAMTEL",
                                        "image": "assets/images/camtel.jpeg",
                                        "value": "Camtel"
                                      },
                                      {
                                        'title': "MTN",
                                        "image": "assets/images/mtn.png",
                                        "value": "MTN"
                                      },
                                      // {
                                      //   'title': "NEXTEL",
                                      //   "image": "assets/images/nextel.png",
                                      //   "value": "Nextel"
                                      // },
                                      {
                                        'title': "ORANGE",
                                        "image": "assets/images/orange.png",
                                        "value": "Orange"
                                      },
                                      {
                                        'title': "YO0MEE",
                                        "image": "assets/images/yoomee.png",
                                        "value": "Yoomee"
                                      },
                                    ]
                                        .map<PopupMenuItem>((e) =>
                                            PopupMenuItem(
                                              onTap: () {
                                                setState(() {
                                                  // coupon = e['title'];
                                                  widget.data["reseau"] =
                                                      e["value"];
                                                  print(e["value"]);
                                                });
                                                print(coupon);
                                              },
                                              child: ListTile(
                                                leading: Image.asset(
                                                  e["image"].toString(),
                                                  width: 30,
                                                ),
                                                title: Text(
                                                  e['title'].toString(),
                                                  style: const TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    offset: const Offset(0.0, 30),
                                    child: const Icon(
                                      Icons.expand_more,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
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
                              widget.data["numero"] =
                                  value; // Update the data map when the text changes
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
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            initialValue: widget.data["montant"],
                            onChanged: (value) {
                              setState(() {
                                widget.data["montant"] = value;
                              });
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "${AppLocalizations.of(context)!.translate("Saisire montant")}",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: blueColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50)),
                          onPressed: () {
                            widget.data["reseau"] =
                                widget.data["reseau"].toString().split(" ")[0];
                            print(widget.data);
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: AchatCreditPassword(
                                        parentcontext: context,
                                        data: widget.data)));
                          },
                          child: Text(
                            "${AppLocalizations.of(context)!.translate('suivant')}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              child: _isLoading
                  ? Loader(
                      color: blueColor,
                    )
                  : Container())
        ]));
  }
}
