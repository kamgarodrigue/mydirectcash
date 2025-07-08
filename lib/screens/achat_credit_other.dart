import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
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
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AchatCreditauther extends StatefulWidget {
  Map data;
  AchatCreditauther({Key? key, required this.data}) : super(key: key);

  @override
  _AchatCreditState createState() => _AchatCreditState();
}

class _AchatCreditState extends StateMVC<AchatCreditauther> {
  bool _isLoading = false;

  UserController? _userController;
  String? codeRegion = "CM";
  String? reseauImage;
  Contact? _selectedContact;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printUserCountry();
    context.read<AuthService>().authenticate;

    _controller.text = "";
    print(widget.data);
  }

  String? country;
  String? _code;
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
            widget.data["vToNumber"] = phoneWithoutCode.toString();
          });
        } else {
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

  void goToAirtimePassword(dynamic data) {
    var param = {};
    print(country);
    if (country != "Cameroon") {
      setState(() {
        _isLoading = true;
        param = {
          "amount": data['vAmount'],
          "to": data["vClientID"],
          "transactionType": "0",
        };
      });
      print(param);
      TransactonService().getDetailEnvoiDirectcash(param).then((value) {
        print(value);
        widget.data["vrate"] = value['data']['fees'];
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child:
                AchatCreditPassword(parentcontext: context, data: widget.data),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        print(error);
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: AppLocalizations.of(context)!.translate("erreur")!,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: AchatCreditPassword(parentcontext: context, data: widget.data),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final autProvider = context.watch<AuthService>();
    print(country);
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
                        "${AppLocalizations.of(context)!.translate('Achat de crédit')}-${widget.data["vreseau"] == "" ? AppLocalizations.of(context)!.translate('networkSelect') : widget.data["vreseau"]}",
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
                                                  widget.data["vreseau"] =
                                                      e["value"];
                                                  reseauImage = e["image"];
                                                  print(e["value"]);
                                                });
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
                            ),
                            Expanded(child: Container()),
                            reseauImage != null
                                ? Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                          reseauImage!,
                                        )),
                                        borderRadius: BorderRadius.circular(5)),
                                  )
                                : const SizedBox(
                                    height: 50,
                                    width: 50,
                                  ),
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
                              widget.data["vToNumber"] =
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
                              onPressed: _pickContact,
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
                            // initialValue: widget.data["vAmount"],
                            onChanged: (value) {
                              setState(() {
                                widget.data["vAmount"] = value;
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
                            if (widget.data["vAmount"] == "" ||
                                widget.data["vToNumber"] == "" ||
                                widget.data["vreseau"] == "") {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.info(
                                  message:
                                      " ${AppLocalizations.of(context)!.translate('veille')}",
                                ),
                              );
                            } else {
                              widget.data["vClientID"] =
                                  autProvider.currentUser!.data!.phone;
                              print(widget.data);

                              goToAirtimePassword(widget.data);
                            }
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
