import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Resset_Password extends StatefulWidget {
  final dynamic data;

  Resset_Password({Key? key, required this.data}) : super(key: key);

  @override
  State<Resset_Password> createState() => _Resset_PasswordState();
}

class _Resset_PasswordState extends State<Resset_Password> {
  bool _isLoading = false;

  String? code = "";
  String? pass = "";
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                        text: "Vous avez recu un code sur ",
                        children: [
                          TextSpan(
                              text: "${widget.data["email"]}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ],
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 15)),
                    textAlign: TextAlign.center,
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
                            initialValue: code,
                            onChanged: (value) {
                              setState(() {
                                code = value;
                              });
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "${AppLocalizations.of(context)!.translate('code')}",
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
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            initialValue: pass,
                            onChanged: (value) {
                              setState(() {
                                pass = value;
                              });
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "${AppLocalizations.of(context)!.translate("Password1")}",
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

                              context.read<AuthService>().ResetPass({
                                "code": code,
                                "Pass": pass,
                                "phone": widget.data["phone"]
                              }).then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.info(
                                    message: value.toString(),
                                  ),
                                );

                                // print(value);
                              }).catchError((error) {
                                print(error);
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message: error.toString(),
                                  ),
                                );

                                setState(() {
                                  _isLoading = false;
                                });
                              });
                            },
                            child: Text(
                              "${AppLocalizations.of(context)!.translate('Valider')}",
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
