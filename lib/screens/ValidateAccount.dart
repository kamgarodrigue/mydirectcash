import 'dart:async';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../widgets/Loader.dart';

class ValidateAccount extends StatefulWidget {
  final String? phoneNumber;
  Function? goToLogin;
  Function? goreturn;
  ValidateAccount({Key? key, this.phoneNumber, this.goToLogin, this.goreturn})
      : super(key: key);

  @override
  State<ValidateAccount> createState() => _ValidateAccountState();
}

class _ValidateAccountState extends State<ValidateAccount> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  String currentText = "";
  bool hasError = false;
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static const Color primaryColor = Color(0xffFBFBFB);
  static const String otpGifImage = "assets/images/otp.gif";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(otpGifImage),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Verification De Votre Compte',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8),
                      child: RichText(
                        text: const TextSpan(
                            text:
                                "Saisir le code envoye  dans votre boite mail",
                            children: [
                              TextSpan(
                                  text: "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ],
                            style: TextStyle(
                                color: Colors.black54, fontSize: 15)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: blueColor,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: true,
                            obscuringCharacter: '*',

                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v!.length < 3) {
                                return "I'm from validator";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              // borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            /*boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],*/
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        hasError
                            ? "*Please fill up all the cells properly"
                            : "",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            context.read<AuthService>().resendCodeValidation(
                                {"phone": widget.phoneNumber}).then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              print(value.toString());
                            }).catchError((err) {
                              setState(() {
                                _isLoading = false;
                              });
                              print(err);
                              showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: err.toString(),
                                  ),
                                  displayDuration: const Duration(seconds: 2));
                            });
                          },
                          child: Text(
                            "RESEND",
                            style: TextStyle(
                                color: blueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: blueColor,
                                offset: const Offset(1, -2),
                                blurRadius: 5),
                            BoxShadow(
                                color: blueColor,
                                offset: const Offset(-1, 2),
                                blurRadius: 5)
                          ]),
                      child: ButtonTheme(
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            formKey.currentState!.validate();
                            // conditions for validating
                            if (currentText.length != 6) {
                              errorController!.add(ErrorAnimationType
                                  .shake); // Triggering error shake animation 628094
                              setState(() => hasError = true);
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              context.read<AuthService>().validation({
                                "phone": widget.phoneNumber,
                                "code": currentText
                              }).then((value) {
                                setState(
                                  () {
                                    hasError = false;
                                  },
                                );
                                if (value.toString() == "Success") {
                                  widget.goToLogin!();
                                  showTopSnackBar(
                                   Overlay.of(context),
                                    CustomSnackBar.success(
                                      message: "$value  Votre compte a ete verifier",
                                    ),
                                  );
                                } else {
                                  showTopSnackBar(
                                 Overlay.of(context),
                                    CustomSnackBar.success(
                                      message:
                                          "$value  Code invalide",
                                    ),
                                  );
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              }).catchError((err) {
                                setState(() {
                                  _isLoading = false;
                                });
                                print("err$err");
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: err.toString(),
                                  ),
                                );
                                setState(
                                  () {
                                    hasError = true;
                                    // snackBar("OTP Verified!!");
                                  },
                                );
                              });
                            }
                          },
                          child: Center(
                              child: Text(
                            "VERIFIER".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                            child: TextButton(
                          child: const Text("Retour"),
                          onPressed: () {
                            widget.goToLogin!();
                          },
                        )),
                        Flexible(
                            child: TextButton(
                          child: const Text("Clear"),
                          onPressed: () {
                            textEditingController.clear();
                          },
                        )),
                        /* Flexible(
                            child: TextButton(
                          child: const Text("Set Text"),
                          onPressed: () {
                            setState(() {
                              textEditingController.text = "12345";
                            });
                          },
                        )),*/
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
                child: _isLoading
                    ? Loader(
                        loadingTxt:
                            "${AppLocalizations.of(context)!.translate('loaderconex')}")
                    : Container())
          ],
        ));
  }
}
