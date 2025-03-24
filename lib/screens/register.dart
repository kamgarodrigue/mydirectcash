// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Cgu.dart';
import 'package:mydirectcash/screens/ValidateAccount.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:mydirectcash/widgets/t.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  Function? goToLogin;
  Function? goreturn;
  Function? completpROfile;
  Register({super.key, this.goToLogin, this.completpROfile, this.goreturn});

  @override
  State<Register> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<Register> {
  final PageController _pageController = PageController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _cniDateController = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  PhoneNumber number = PhoneNumber(isoCode: 'CM', phoneNumber: '');
  RegExp emailReg = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  Map dataUser = {
    "Pass": "",
    "Pass1": "",
    "Nom": "",
    "Phone": "",
    "Photo": "",
    "Email": "",
    "contact": "",
    "sexe": "",
    "pays": "",
    "code": "",
    "Ville": "",
    "Adresse": "",
    "numeroConntact": "",
    "nomConntact": "",
    "CNI": "",
    "p_dateValidationCNI": "",
    "dateNaissance": "",
    "profession": "",
    "CNI1": "",
    "nui": "",
    "registre": " "
  };
  XFile? carteR = XFile(" ");
  XFile? carteV = XFile(" ");
  XFile? passeport = XFile(" ");
  XFile? profile = XFile(" ");
  Future<void> getcarteR() async {
    final ImagePicker picker = ImagePicker();
    final response = await picker.pickImage(source: ImageSource.gallery);

    if (response != null) {
      setState(() {
        carteR = response;
      });
    } else {}
  }

  Future<void> getcarteV() async {
    final ImagePicker picker = ImagePicker();
    final response = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      carteV = response;
    });
  }

  Future<void> getpasseport() async {
    final ImagePicker picker = ImagePicker();
    final response = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      passeport = response;
    });
  }

  Future<void> getprofil() async {
    final ImagePicker picker = ImagePicker();
    final response = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      profile = response;
    });
  }

  bool _isOscure = true;
  bool _isverify = false;
  bool isCNI = true;
  void togle() {
    setState(() {
      _isOscure = !_isOscure;
    });
  }

  bool _isLoading = false;
  final _keyform = GlobalKey<FormState>();
  String? _selectedPlan = "Sexe";

  int _currentPage = 0;
  bool _obscureText = true;
  bool isOk = true;

  @override
  void dispose() {
    _dateController.dispose();
    _cniDateController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
        _cniDateController.text =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
        dataUser["dateNaissance"] = _dateController.text;
        dataUser["CNIExpiration"] = _cniDateController.text;
      });
    }
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF303030),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xFFD5D7D8))),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword ? _obscureText : false,
            validator: (value) {
              if (value == null || value.isEmpty) {}
              return null;
            },
            onTap: () {
              setState(() {
                isOk = false;
                print(isOk);
              });
            },
            decoration: InputDecoration(
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          color: Color(0xFFD0D2D1),
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
                contentPadding: EdgeInsets.only(top: 1, left: 10),
                border: InputBorder.none),
          ),
        ),
        isOk
            ? Container()
            : Text(
                " Veuillez entrer votre $label",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              )
      ],
    );
  }

  Widget _buildDropdownButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          child: DropdownButtonFormField<String>(
            value: _selectedPlan,
            isExpanded: true,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color:
                      blueColor, // Couleur de la bordure lorsque le champ est en focus
                  width: 2.0,
                ),
              ),
            ),
            items: <String>[
              "Sexe",
              'Masculin',
              'Feminnin',
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedPlan = newValue;
                dataUser["sexe"] = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez choisir un ';
              }
              return null;
            },
          ),
        ),
        isOk
            ? Container()
            : Text(
                'Veuillez choisir un plan',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              )
      ],
    );
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return _isverify
        ? ValidateAccount(
            phoneNumber: dataUser["Phone"],
            goToLogin: () {
              setState(() {
                _isverify = false;
                widget.goToLogin!();
              });
            },
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/backgroud.png"))),
              child: Padding(
                padding:
                    EdgeInsets.only(top: height * 0.07, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 32, left: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) {
                          return Column(
                            children: [
                              Container(
                                width: 12.0,
                                height: 12.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPage == index
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              if (index == 0)
                                Text(
                                  "Information",
                                  style: TextStyle(
                                      color: _currentPage == 0 && index == 0
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: title_font,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              if (index == 1)
                                Text(
                                  "Localisation",
                                  style: TextStyle(
                                      color: _currentPage == 1 && index == 1
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: title_font,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              if (index == 2)
                                Text(
                                  "Identification",
                                  style: TextStyle(
                                      color: _currentPage == 2 && index == 2
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: title_font,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                // padding: EdgeInsets.only(left: 16,right: 16),
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/background.png'),
                                        fit: BoxFit.cover)),
                                child: ListView(
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      height: 140,
                                      child: Image.asset(
                                        'assets/images/logo-alliance-transparent.png',
                                      ),
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.translate('title')}",
                                            style: TextStyle(
                                                fontFamily: title_font,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "${AppLocalizations.of(context)!.translate('message')}",
                                            style: TextStyle(
                                                fontFamily: content_font,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Form(
                                      key: _formKey1,
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: InternationalPhoneNumberInput(
                                            onInputChanged:
                                                (PhoneNumber number) {
                                              print(number.phoneNumber);
                                              setState(() {
                                                dataUser["Phone"] =
                                                    number.phoneNumber;
                                              });

                                              ///  dataUser["Phone"]==number.phoneNumber;
                                            },
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return "Ajoutez un numero !";
                                              }
                                              if (value.length < 9 ||
                                                  value.length > 14) {
                                                return "Numero invalid !";
                                              }
                                            },
                                            onInputValidated: (bool isValid) {
                                              print(isValid);
                                            },
                                            selectorConfig: SelectorConfig(
                                              selectorType:
                                                  PhoneInputSelectorType
                                                      .DROPDOWN,
                                              setSelectorButtonAsPrefixIcon:
                                                  true,
                                              leadingPadding: 8.0,
                                              showFlags: true,
                                              useEmoji: true,
                                            ),
                                            ignoreBlank: false,
                                            autoValidateMode:
                                                AutovalidateMode.disabled,
                                            selectorTextStyle:
                                                TextStyle(color: Colors.black),
                                            initialValue: number,
                                            textFieldController:
                                                _phonecontroller,
                                            formatInput: false,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    signed: true,
                                                    decimal: true),
                                            inputDecoration: InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
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
                                                  fontSize: 14),
                                            ),
                                            onSaved: (PhoneNumber number) {
                                              print('On Saved: $number');
                                              setState(
                                                () {
                                                  dataUser["Phone"] =
                                                      number.phoneNumber;
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            initialValue: dataUser["Nom"],
                                            onChanged: (val) {
                                              dataUser["Nom"] = val;
                                            },
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return "${AppLocalizations.of(context)!.translate('name')} *";
                                              }
                                            },
                                            style: TextStyle(
                                              fontFamily: content_font,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.start,
                                            cursorColor: blueColor,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: blueColor,
                                                      width: 2),
                                                ),
                                                hintText:
                                                    "${AppLocalizations.of(context)!.translate('name')} *",
                                                hintStyle: TextStyle(
                                                    fontFamily: content_font,
                                                    color: Colors.grey.shade500,
                                                    fontSize: 14)),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                  fontFamily: content_font,
                                                  fontSize: 14),
                                              textAlign: TextAlign.start,
                                              initialValue: dataUser["Email"],
                                              onChanged: (val) {
                                                dataUser["Email"] = val;
                                              },
                                              validator: (value) {
                                                if (value!.trim().isEmpty) {
                                                  return "Entrez le mail";
                                                }
                                                if (!emailReg.hasMatch(value)) {
                                                  return "Email Invalid";
                                                }
                                              },
                                              cursorColor: blueColor,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: blueColor,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  hintText:
                                                      "${AppLocalizations.of(context)!.translate('email')} *",
                                                  hintStyle: TextStyle(
                                                      fontFamily: content_font,
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontSize: 14)),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                  fontFamily: content_font,
                                                  fontSize: 14),
                                              textAlign: TextAlign.start,
                                              initialValue:
                                                  dataUser["profession"],
                                              onChanged: (val) {
                                                dataUser["profession"] = val;
                                              },
                                              validator: (value) {
                                                if (value!.trim().isEmpty) {
                                                  return "${AppLocalizations.of(context)!.translate('profession')} *";
                                                }
                                              },
                                              cursorColor: blueColor,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: blueColor,
                                                        width: 2),
                                                  ),
                                                  hintText:
                                                      "${AppLocalizations.of(context)!.translate('profession')} *",
                                                  hintStyle: TextStyle(
                                                      fontFamily: content_font,
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontSize: 14)),
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: TextFormField(
                                              controller: _dateController,
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                  fontFamily: content_font,
                                                  fontSize: 14),
                                              textAlign: TextAlign.start,
                                              // initialValue: dataUser["dateNaissance"],
                                              readOnly: true,
                                              onTap: () => _selectDate(context),
                                              onChanged: (val) {
                                                dataUser["dateNaissance"] = val;
                                              },
                                              cursorColor: blueColor,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: blueColor,
                                                        width: 2),
                                                  ),
                                                  hintText:
                                                      "${AppLocalizations.of(context)!.translate('dateNaissance')} *",
                                                  hintStyle: TextStyle(
                                                      fontFamily: content_font,
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontSize: 14)),
                                            )),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                  fontFamily: content_font,
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign.start,
                                                onChanged: (val) {
                                                  setState(() =>
                                                      dataUser["registre"] =
                                                          val);
                                                },
                                                cursorColor: blueColor,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: blueColor,
                                                        width: 2),
                                                  ),
                                                  hintText: AppLocalizations.of(
                                                          context)!
                                                      .translate('registe'),
                                                  hintStyle: TextStyle(
                                                    fontFamily: content_font,
                                                    color: Colors.grey.shade500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Laissez le registre vide si vous etes un particulier!",
                                                style: TextStyle(
                                                  fontFamily: content_font,
                                                  color: blueColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    activeColor: blueColor,
                                                    value: "M",
                                                    groupValue:
                                                        dataUser["sexe"],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        dataUser["sexe"] = "M";
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text("Homme")
                                                ],
                                              ),
                                              SizedBox(width: 20),
                                              Row(
                                                children: [
                                                  Radio(
                                                    activeColor: blueColor,
                                                    value: "F",
                                                    groupValue:
                                                        dataUser["sexe"],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        dataUser["sexe"] = "F";
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text("Femme")
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Wrap(
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                blueColor,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        50)),
                                                    onPressed: () {
                                                      if (_formKey1
                                                          .currentState!
                                                          .validate()) {
                                                        if (dataUser["profession"] != "" &&
                                                            dataUser["Nom"] !=
                                                                "" &&
                                                            dataUser["Phone"] !=
                                                                "" &&
                                                            dataUser["Email"] !=
                                                                "" &&
                                                            dataUser[
                                                                    "dateNaissance"] !=
                                                                "" &&
                                                            dataUser["sexe"] !=
                                                                "") {
                                                          _nextPage();
                                                          print(dataUser);
                                                        } else {
                                                          showTopSnackBar(
                                                            Overlay.of(context),
                                                            CustomSnackBar
                                                                .error(
                                                              message:
                                                                  "${AppLocalizations.of(context)!.translate('veille')} ",
                                                            ),
                                                          );
                                                        }
                                                        setState(() {
                                                          // this._isLoading = true;
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      "${AppLocalizations.of(context)!.translate('Valider')}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                              "${AppLocalizations.of(context)!.translate('condition')}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: content_font,
                                                  fontSize: 12,
                                                  color: Colors.grey.shade500)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: Cgu()));
                                            },
                                            child: Text(
                                                "${AppLocalizations.of(context)!.translate('Lire')}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 16,
                                                    color: blueColor)),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      child: GestureDetector(
                                          onTap: () {
                                            widget.goToLogin!();
                                          },
                                          child: Text(
                                              "${AppLocalizations.of(context)!.translate('Jai déjà un compte')}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: content_font,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: blueColor))),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  child: _isLoading
                                      ? Loader(loadingTxt: '')
                                      : Container())
                            ],
                          ),

//=========================================================================================================

                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/background.png'),
                                          fit: BoxFit.cover)),
                                  child: ListView(
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        height: 140,
                                        child: Image.asset(
                                          'assets/images/logo-alliance-transparent.png',
                                        ),
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${AppLocalizations.of(context)!.translate('title')}",
                                              style: TextStyle(
                                                  fontFamily: title_font,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "${AppLocalizations.of(context)!.translate('message')}",
                                              style: TextStyle(
                                                  fontFamily: content_font,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Form(
                                        key: _formKey2,
                                        child: Column(children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Column(
                                              children: [
                                                CSCPicker(
                                                  showStates: false,
                                                  showCities: false,
                                                  flagState: CountryFlag.ENABLE,
                                                  countrySearchPlaceholder:
                                                      "${AppLocalizations.of(context)!.translate('pays')} *",
                                                  countryDropdownLabel: dataUser[
                                                              "pays"]
                                                          .toString()
                                                          .isEmpty
                                                      ? "${AppLocalizations.of(context)!.translate('pays')} *"
                                                      : dataUser["pays"]
                                                          .toString(),
                                                  dropdownDialogRadius: 10.0,
                                                  searchBarRadius: 10.0,
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius.circular(
                                                                      10)),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade300,
                                                              width: 1)),
                                                  disabledDropdownDecoration:
                                                      BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          color: Colors
                                                              .grey.shade300,
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade300,
                                                              width: 1)),
                                                  dropdownHeadingStyle:
                                                      const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  dropdownItemStyle:
                                                      const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                  selectedItemStyle:
                                                      const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                  onCountryChanged: (value) {
                                                    setState(() {
                                                      dataUser["pays"] =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                                // TextFormField(
                                                //   keyboardType:
                                                //       TextInputType.text,
                                                //   initialValue: dataUser["pays"]
                                                //       .toString(),
                                                //   onChanged: (val) {
                                                //     setState(() {
                                                //       dataUser["pays"] = val;
                                                //     });
                                                //   },
                                                //   style: TextStyle(
                                                //       fontFamily: content_font,
                                                //       fontSize: 14),
                                                //   textAlign: TextAlign.start,
                                                //   decoration: InputDecoration(
                                                //       hintText:
                                                //           "${AppLocalizations.of(context)!.translate('pays')} *",
                                                //       hintStyle: TextStyle(
                                                //           fontFamily:
                                                //               content_font,
                                                //           color: Colors
                                                //               .grey.shade500,
                                                //           fontSize: 14)),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 14),
                                                textAlign: TextAlign.start,
                                                initialValue: dataUser["Ville"],
                                                onChanged: (val) {
                                                  setState(() {
                                                    dataUser["Ville"] = val;
                                                  });
                                                },
                                                cursorColor: blueColor,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blueColor,
                                                          width: 2),
                                                    ),
                                                    hintText:
                                                        "${AppLocalizations.of(context)!.translate('Ville')} *",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            content_font,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14)),
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              initialValue: dataUser["code"],
                                              onChanged: (val) {
                                                setState(() {
                                                  dataUser["code"] = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontFamily: content_font,
                                                  fontSize: 14),
                                              textAlign: TextAlign.start,
                                              cursorColor: blueColor,
                                              decoration: InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: blueColor,
                                                        width: 2),
                                                  ),
                                                  hintText:
                                                      "${AppLocalizations.of(context)!.translate('codep')} *",
                                                  hintStyle: TextStyle(
                                                      fontFamily: content_font,
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontSize: 14)),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 14),
                                                textAlign: TextAlign.start,
                                                initialValue:
                                                    dataUser["Adresse"],
                                                onChanged: (val) {
                                                  setState(() {
                                                    dataUser["Adresse"] = val;
                                                  });
                                                },
                                                cursorColor: blueColor,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blueColor,
                                                          width: 2),
                                                    ),
                                                    hintText:
                                                        "${AppLocalizations.of(context)!.translate('Adresse')} *",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            content_font,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14)),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 14),
                                                textAlign: TextAlign.start,
                                                initialValue:
                                                    dataUser["nomConntact"],
                                                onChanged: (val) {
                                                  setState(() {
                                                    dataUser["nomConntact"] =
                                                        val;
                                                  });
                                                },
                                                cursorColor: blueColor,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blueColor,
                                                          width: 2),
                                                    ),
                                                    hintText:
                                                        "${AppLocalizations.of(context)!.translate('Contact')} *",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            content_font,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14)),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 14),
                                                textAlign: TextAlign.start,
                                                initialValue:
                                                    dataUser["numeroConntact"],
                                                onChanged: (val) {
                                                  setState(() {
                                                    dataUser["numeroConntact"] =
                                                        val;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "${AppLocalizations.of(context)!.translate('Numéro du contact')} *",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            content_font,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14)),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                initialValue: dataUser["CNI"],
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 14),
                                                textAlign: TextAlign.start,
                                                onChanged: (val) {
                                                  setState(() {
                                                    dataUser["CNI"] = val;
                                                  });
                                                },
                                                cursorColor: blueColor,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blueColor,
                                                          width: 2),
                                                    ),
                                                    hintText:
                                                        "${AppLocalizations.of(context)!.translate('CNI2')} *",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            content_font,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14)),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 14),
                                                textAlign: TextAlign.start,
                                                initialValue: dataUser["nui"],
                                                onChanged: (val) {
                                                  setState(() {
                                                    dataUser["nui"] = val;
                                                  });
                                                },
                                                cursorColor: blueColor,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blueColor,
                                                          width: 2),
                                                    ),
                                                    hintText:
                                                        "${AppLocalizations.of(context)!.translate('Nui')} *",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            content_font,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14)),
                                              )),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Wrap(
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  blueColor,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          50)),
                                                      onPressed: () {
                                                        _previousPage();
                                                      },
                                                      child: Text(
                                                        "${AppLocalizations.of(context)!.translate('retour')}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  blueColor,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          50)),
                                                      onPressed: () {
                                                        if (dataUser[
                                                                    "CNI"] !=
                                                                "" &&
                                                            dataUser[
                                                                    "nomConntact"] !=
                                                                "" &&
                                                            dataUser[
                                                                    "numeroConntact"] !=
                                                                "" &&
                                                            dataUser[
                                                                    "Adresse"] !=
                                                                "" &&
                                                            dataUser[
                                                                    "Ville"] !=
                                                                "" &&
                                                            dataUser["code"] !=
                                                                "" &&
                                                            dataUser["pays"] !=
                                                                "") {
                                                          _nextPage();
                                                          print(dataUser);
                                                        } else {
                                                          showTopSnackBar(
                                                            Overlay.of(context),
                                                            CustomSnackBar
                                                                .error(
                                                              message:
                                                                  "${AppLocalizations.of(context)!.translate('veille')} ",
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Text(
                                                        "${AppLocalizations.of(context)!.translate('suivant')}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    child: _isLoading
                                        ? Loader(loadingTxt: '')
                                        : Container())
                              ],
                            ),
                          ),
//=========================================================================================

                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/background.png'),
                                          fit: BoxFit.cover)),
                                  child: ListView(
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        height: 140,
                                        child: Image.asset(
                                          'assets/images/logo-alliance-transparent.png',
                                        ),
                                      ),
                                      Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${AppLocalizations.of(context)!.translate('title')}",
                                              style: TextStyle(
                                                  fontFamily: title_font,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "${AppLocalizations.of(context)!.translate('message')}",
                                              style: TextStyle(
                                                  fontFamily: content_font,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Form(
                                        key: _formKey3,
                                        child: Column(children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate('CNI')
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  content_font)),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Radio(
                                                            value: isCNI,
                                                            activeColor:
                                                                blueColor,
                                                            groupValue: true,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                isCNI = true;
                                                              });
                                                            }),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 30),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'passeport')
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  content_font)),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: Radio(
                                                            activeColor:
                                                                blueColor,
                                                            value: !isCNI,
                                                            groupValue: true,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                isCNI = false;
                                                              });
                                                            }),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (isCNI)
                                            InkWell(
                                              onTap: () => getcarteR(),
                                              child: CustomPaint(
                                                painter: DashedBorderPainter(),
                                                child: Container(
                                                  height: 130,
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      image: DecorationImage(
                                                          image: FileImage(File(
                                                              carteR!.path)),
                                                          fit: BoxFit.cover)),
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: 70,
                                                      child: Column(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/Group.png",
                                                            height: 40,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "${AppLocalizations.of(context)!.translate('Selectionner le recto')}",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          if (isCNI)
                                            InkWell(
                                              onTap: () => getcarteV(),
                                              child: CustomPaint(
                                                painter: DashedBorderPainter(),
                                                child: Container(
                                                  height: 130,
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      image: DecorationImage(
                                                          image: FileImage(File(
                                                              carteV!.path)),
                                                          fit: BoxFit.cover)),
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: 70,
                                                      child: Column(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/Group.png",
                                                            height: 40,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "${AppLocalizations.of(context)!.translate('Selectionner le verso')}",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          if (!isCNI)
                                            InkWell(
                                              onTap: () => getpasseport(),
                                              child: CustomPaint(
                                                painter: DashedBorderPainter(),
                                                child: Container(
                                                  height: 130,
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      image: DecorationImage(
                                                          image: FileImage(File(
                                                              passeport!.path)),
                                                          fit: BoxFit.cover)),
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: 70,
                                                      child: Column(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/Group.png",
                                                            height: 40,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "${AppLocalizations.of(context)!.translate('Selectionner le Passeport')}",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          InkWell(
                                            onTap: () => getprofil(),
                                            child: CustomPaint(
                                              painter: DashedBorderPainter(),
                                              child: Container(
                                                height: 130,
                                                width: width,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                        image: FileImage(File(
                                                            profile!.path)),
                                                        fit: BoxFit.cover)),
                                                child: Center(
                                                  child: SizedBox(
                                                    height: 70,
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/Group.png",
                                                          height: 40,
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "${AppLocalizations.of(context)!.translate('Selectionner le photo')}",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 14),
                                                textAlign: TextAlign.start,
                                                onChanged: (val) {
                                                  setState(() {
                                                    dataUser["CNI1"] = val;
                                                  });
                                                },
                                                cursorColor: blueColor,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blueColor,
                                                          width: 2),
                                                    ),
                                                    hintText:
                                                        "${AppLocalizations.of(context)!.translate('CNI1')} *",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            content_font,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14)),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextFormField(
                                                controller: _cniDateController,
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 14),
                                                textAlign: TextAlign.start,
                                                // initialValue: dataUser["dateNaissance"],
                                                readOnly: true,
                                                onTap: () =>
                                                    _selectDate(context),
                                                onChanged: (val) {
                                                  dataUser["CNIExpiration"] =
                                                      val;
                                                },
                                                cursorColor: blueColor,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blueColor,
                                                          width: 2),
                                                    ),
                                                    hintText:
                                                        "${AppLocalizations.of(context)!.translate('CNIExpiration')} *",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            content_font,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14)),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                obscureText: true,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 14),
                                                textAlign: TextAlign.start,
                                                initialValue: dataUser["Pass"],
                                                onChanged: (val) {
                                                  setState(() {
                                                    dataUser["Pass"] = val;
                                                  });
                                                },
                                                cursorColor: blueColor,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blueColor,
                                                          width: 2),
                                                    ),
                                                    /* suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.visibility,
                                        size: 16,
                                      ),
                                      onPressed: () => togle(),
                                    ),*/
                                                    hintText:
                                                        "${AppLocalizations.of(context)!.translate('password1')}",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            content_font,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14)),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                obscureText: true,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 14),
                                                textAlign: TextAlign.start,
                                                initialValue: dataUser["Pass1"],
                                                onChanged: (val) {
                                                  setState(() {
                                                    dataUser["Pass1"] = val;
                                                  });
                                                },
                                                cursorColor: blueColor,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blueColor,
                                                          width: 2),
                                                    ),
                                                    /* suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.visibility,
                                        size: 16,
                                      ),
                                      onPressed: () => togle(),
                                    ),*/
                                                    hintText:
                                                        "${AppLocalizations.of(context)!.translate('confirmation du mot de passe')}",
                                                    hintStyle: TextStyle(
                                                        fontFamily:
                                                            content_font,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontSize: 14)),
                                              )),
                                          dataUser["Pass1"] == dataUser["Pass"]
                                              ? Container()
                                              : Text(
                                                  "${AppLocalizations.of(context)!.translate('Les mot de passe sont differents')}",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Wrap(
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  blueColor,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          50)),
                                                      onPressed: () {
                                                        _previousPage();
                                                      },
                                                      child: Text(
                                                        "${AppLocalizations.of(context)!.translate('retour')}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  blueColor,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          50)),
                                                      onPressed: () {
                                                        bool image = (carteR !=
                                                                    null &&
                                                                carteV !=
                                                                    null) ||
                                                            passeport != null;

                                                        print(passeport!.path);
                                                        print(carteR!.path);
                                                        print(carteV!.path);
                                                        print(dataUser);

                                                        if (image &&
                                                            profile!.path !=
                                                                " " &&
                                                            dataUser["CNI1"] !=
                                                                "" &&
                                                            dataUser["Pass"] !=
                                                                "" &&
                                                            dataUser["Pass"] ==
                                                                dataUser[
                                                                    "Pass1"]) {
                                                          //     _nextPage();

                                                          setState(() {
                                                            _isLoading = true;
                                                          });

                                                          AuthService()
                                                              .registerWithKyc(
                                                            vnomClient:
                                                                dataUser["Nom"],
                                                            vphone: dataUser[
                                                                "Phone"],
                                                            vpays: dataUser[
                                                                "pays"],
                                                            vadresse: dataUser[
                                                                "Adresse"],
                                                            vurlphoto:
                                                                "MydirectCash",
                                                            vdeviceId: "device",
                                                            vemail: dataUser[
                                                                "Email"],
                                                            vpass: dataUser[
                                                                "Pass"],
                                                            p_identiteNo:
                                                                dataUser[
                                                                    "CNI1"],
                                                            p_NUI:
                                                                dataUser["nui"],
                                                            p_Profession:
                                                                dataUser[
                                                                    "profession"],
                                                            p_cniNo: dataUser[
                                                                "CNI1"],
                                                            p_RegistreCom:
                                                                dataUser[
                                                                    "registre"],
                                                            p_Datenaissance:
                                                                dataUser[
                                                                    "dateNaissance"],
                                                            p_CNIContact:
                                                                dataUser["CNI"],
                                                            p_dateValidationCNI:
                                                                dataUser[
                                                                    "CNIExpiration"],
                                                            p_phoneContact:
                                                                dataUser[
                                                                    "numeroConntact"],
                                                            p_nomContact: dataUser[
                                                                "nomConntact"],
                                                            p_cniRectoPath:
                                                                carteR != null
                                                                    ? carteR!
                                                                        .path
                                                                    : '', // Vérifie que carteR n'est pas null
                                                            p_cniVersoPath: carteV!
                                                                        .path !=
                                                                    " "
                                                                ? carteV!.path
                                                                : '', // Vérifie que carteV n'est pas null
                                                            p_passportPath:
                                                                passeport!.path !=
                                                                        " "
                                                                    ? passeport!
                                                                        .path
                                                                    : '', // Vérifie que passeport n'est pas null
                                                            p_photoPath:
                                                                profile!.path !=
                                                                        " "
                                                                    ? profile!
                                                                        .path
                                                                    : '',
                                                            Ville: dataUser[
                                                                "Ville"],
                                                            code: dataUser[
                                                                "code"],
                                                            p_sexe: dataUser[
                                                                "sexe"],
                                                          )
                                                              .then((value) {
                                                            // print(value['message']['message']);

                                                            // if (value is List<
                                                            //     dynamic>) {
                                                            //   setState(() {
                                                            //     _isLoading =
                                                            //         false;
                                                            //   });
                                                            //   showTopSnackBar(
                                                            //     Overlay.of(
                                                            //         context),
                                                            //     CustomSnackBar
                                                            //         .info(
                                                            //       message: value[2]["message"]
                                                            //     ),
                                                            //   );
                                                            // } else {
                                                            if (value[
                                                                    "message"] ==
                                                                "Nouvel enregistrement KYC ajouté avec succès.") {
                                                              widget
                                                                  .goToLogin!();
                                                              showTopSnackBar(
                                                                Overlay.of(
                                                                    context),
                                                                CustomSnackBar
                                                                    .success(
                                                                  message:
                                                                      "Compte creer avec sucess",
                                                                ),
                                                              );
                                                            } else {
                                                              setState(() {
                                                                _isLoading =
                                                                    false;
                                                              });
                                                              showTopSnackBar(
                                                                Overlay.of(
                                                                    context),
                                                                CustomSnackBar
                                                                    .info(
                                                                  message: value[
                                                                      "message"],
                                                                ),
                                                              );
                                                            }
                                                            /* setState(() {
                                            _isverify = true;
                                          });*/
                                                          }).catchError(
                                                                  (error) {
                                                            print(error);
                                                            setState(() {
                                                              _isLoading =
                                                                  false;
                                                            });
                                                            showTopSnackBar(
                                                              Overlay.of(
                                                                  context),
                                                              CustomSnackBar
                                                                  .error(
                                                                message: error
                                                                    .toString(),
                                                              ),
                                                            );
                                                          });
                                                        } else {
                                                          showTopSnackBar(
                                                            Overlay.of(context),
                                                            CustomSnackBar
                                                                .error(
                                                              message:
                                                                  "${AppLocalizations.of(context)!.translate('veille')} ",
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Text(
                                                        "${AppLocalizations.of(context)!.translate('suivant')}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                                "${AppLocalizations.of(context)!.translate('condition')}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 12,
                                                    color:
                                                        Colors.grey.shade500)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        child: Cgu()));
                                              },
                                              child: Text(
                                                  "${AppLocalizations.of(context)!.translate('Lire')}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: content_font,
                                                      fontSize: 16,
                                                      color: blueColor)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        child: GestureDetector(
                                            onTap: () {
                                              widget.goToLogin!();
                                            },
                                            child: Text(
                                                "${AppLocalizations.of(context)!.translate('Jai déjà un compte')}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: content_font,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: blueColor))),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    child: _isLoading
                                        ? Loader(loadingTxt: '')
                                        : Container())
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
