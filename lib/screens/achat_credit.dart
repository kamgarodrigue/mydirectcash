import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/OperationServices.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/achat_credit_coupon.dart';
import 'package:mydirectcash/screens/achat_credit_operateur.dart';
import 'package:mydirectcash/screens/achat_credit_password.dart';
import 'package:mydirectcash/screens/login.dart';
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

class AchatCredit extends StatefulWidget {
  AchatCredit({Key? key}) : super(key: key);
  var data;

  @override
  _AchatCreditState createState() => _AchatCreditState();
}

class _AchatCreditState extends StateMVC<AchatCredit> {
  Map data = {
    "montant": "",
    "numero": "",
    "Id": "",
    "reseau": "",
    "device": "123456",
    "pass": "",
    "imei": "5258889",
    "skucode": "",
    "sendValue": ""
  };
  bool _isLoading = false;
  _AchatCreditState() : super(UserController()) {
    _userController = UserController.userController;
    _userController!.utilisateur!.then((value) {
      this.currrentUser = value;
      data["Id"] = value.data!.phone;
    });
  }
  UserController? _userController;
  User? currrentUser;
  String? countryName = "";
  String? coupon = "";
  String? codeRegion = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<OperationServices>().getContryOperator("DZ").then((value) {
      print(value);
    });
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
            padding: EdgeInsets.symmetric(horizontal: 25),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover)),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
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
                SizedBox(
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
                      SizedBox(width: 50),
                      Text(
                          "${AppLocalizations.of(context)!.translate('Achat de crédit')}",
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    'assets/images/logo-alliance-transparent.png',
                  ),
                ),
                SizedBox(
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
                                  countryName! == ""
                                      ? "${AppLocalizations.of(context)!.translate('Choisissez le pays de destination')}"
                                      : countryName!,
                                  style: TextStyle(
                                      color: countryName == ""
                                          ? Colors.grey
                                          : Colors.black,
                                      fontSize: 14)),
                            ),
                            CountryListPick(
                                appBar: AppBar(
                                  backgroundColor: blueColor,
                                  title: Text(countryName! == ""
                                      ? "${AppLocalizations.of(context)!.translate('Choisir un pays')}"
                                      : countryName!),
                                ),
                                theme: CountryTheme(
                                  isShowFlag: false,
                                  isShowTitle: false,
                                  isShowCode: false,
                                  isDownIcon: true,
                                  showEnglishName: true,
                                ),
                                initialSelection: '+237',
                                onChanged: (CountryCode? code) {
                                  setState(() {
                                    countryName = code!.name == null
                                        ? "${AppLocalizations.of(context)!.translate('Choisissez le pays de destination')}"
                                        : "${code.name} ($code)";
                                    codeRegion = code.code;
                                  });
                                  print(code);
                                  // print(countryName);
                                },
                                useUiOverlay: true,
                                useSafeArea: false),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        height: 1.5,
                        color: blueColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: blueColor,
                                padding: EdgeInsets.symmetric(horizontal: 50)),
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              context
                                  .read<OperationServices>()
                                  .getContryOperator(codeRegion)
                                  .then((value) {
                                print(value);
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: Achat_credit_operateur(
                                          regionCode: codeRegion!,
                                          data: data,
                                        )));
                              }).catchError((error) {
                                showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                          "Aucun Operateur trouvé pour ce pays",
                                    ),
                                    displayDuration: Duration(seconds: 2));

                                setState(() {
                                  _isLoading = false;
                                });
                              });
                            },
                            child: Text(
                              "${AppLocalizations.of(context)!.translate('suivant')}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
        ]));
  }
}
