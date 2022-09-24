import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Resset_Password.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Resset_Password_Verification extends StatefulWidget {
  Resset_Password_Verification({Key? key}) : super(key: key);

  @override
  State<Resset_Password_Verification> createState() =>
      _Resset_Password_VerificationState();
}

class _Resset_Password_VerificationState
    extends State<Resset_Password_Verification> {
  bool _isLoading = false;

  String? phoneNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AuthService>().authenticate;
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
                SizedBox(
                  height: 40,
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
                      Expanded(
                          child: Text(
                              "${AppLocalizations.of(context)!.translate('reset1')}",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: title_font,
                                  color: blueColor,
                                  fontWeight: FontWeight.w500)))
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            initialValue: phoneNumber,
                            onChanged: (value) {
                              setState(() {
                                phoneNumber = value;
                              });
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "${AppLocalizations.of(context)!.translate('Phone')}",
                                hintStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey,
                                    fontSize: 13))),
                        Divider(
                          height: 1.5,
                          color: blueColor,
                        ),
                      ],
                    )),
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

                              context.read<AuthService>().askResetPass(
                                  {"phone": phoneNumber}).then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: Resset_Password()));
                                // print(value);
                              }).catchError((error) {
                                print(error);
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message: error.toString(),
                                  ),
                                  showOutAnimationDuration:
                                      Duration(seconds: 2),
                                );

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
