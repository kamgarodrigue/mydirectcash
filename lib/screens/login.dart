import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/country_selection_theme.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth_darwin/types/auth_messages_ios.dart';
import 'package:mydirectcash/Controllers/Authcontroller.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Resset_Password_Verification.dart';
import 'package:mydirectcash/screens/ValidateAccount.dart';
import 'package:mydirectcash/screens/carousel_page.dart';
import 'package:mydirectcash/screens/code_entry.dart';
import 'package:mydirectcash/screens/home.dart';
import 'package:mydirectcash/screens/register.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class Login extends StatefulWidget {
  BuildContext? fatherContext;
  bool isLogin;
  Login({super.key, this.fatherContext, required this.isLogin});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends StateMVC<Login> {
  _LoginState() : super(Authcontroller()) {
    _con = Authcontroller.authController;
  }
  Authcontroller? _con;
  bool isRegister = false;
  setRegister() {
    setState(() {
      isRegister = !isRegister;
    });
    print(isRegister);
  }

  bool _isOscure = true;
  void togle() {
    setState(() {
      _isOscure = !_isOscure;
    });
  }

  bool _isLoading = false;
  // Map creds = {'id': "33662044955", 'pass': "123456"};
  // Map creds = {'id': "", 'pass': ""};
  // completeidAndPass(String id, String pass) {
  //   setState(() {
  //     creds['id'] = id;
  //     creds['pass'] = pass;
  //   });
  // }

  Map creds = {'id': "", 'vpass': "", 'deviceid': " "};
  completeidAndPass(String id, String pass) {
    setState(() {
      creds['id'] = id;
      creds['vpass'] = pass;
      creds['deviceid'] = " ";
    });
  }

  final _keyform = GlobalKey<FormState>();
  bool _isverify = false;

  @override
  Widget build(BuildContext context) {
    return isRegister
        ? Register(
            goToLogin: setRegister,
            completpROfile: completeidAndPass,
          )
        : _isverify
            ? ValidateAccount(
                goToLogin: () {
                  setState(() {
                    _isverify = false;
                  });
                },
                goreturn: () {
                  Navigator.pop(context);
                  Navigator.pop(widget.fatherContext!);
                },
                phoneNumber: creds['id'],
              )
            : Scaffold(
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
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: 140,
                            height: 140,
                            child: Image.asset(
                              'assets/images/logo-alliance-transparent.png',
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.translate('title')}",
                                  style: const TextStyle(
                                      fontFamily: title_font,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  "${AppLocalizations.of(context)!.translate('message')}",
                                  style: const TextStyle(
                                      fontFamily: content_font, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _keyform,
                            child: Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      initialValue: creds['id'],
                                      onChanged: (value) {
                                        creds['id'] = value;
                                      },
                                      style: const TextStyle(
                                          fontFamily: content_font,
                                          fontSize: 14),
                                      textAlign: TextAlign.start,
                                      cursorColor: blueColor,
                                      decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
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
                                              fontSize: 14)),
                                    )),
                                // Container(
                                //     margin: const EdgeInsets.only(top: 20),
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 25),
                                //     child: TextFormField(
                                //       keyboardType: TextInputType.text,
                                //       initialValue: creds['pass'],
                                //       onChanged: (value) {
                                //         creds['pass'] = value;
                                //       },
                                //       obscureText: _isOscure,
                                //       style: const TextStyle(
                                //           fontFamily: content_font,
                                //           fontSize: 14),
                                //       textAlign: TextAlign.start,
                                //       cursorColor: blueColor,
                                //       decoration: InputDecoration(
                                //           focusedBorder: UnderlineInputBorder(
                                //             borderSide: BorderSide(
                                //               color: blueColor,
                                //               width: 2,
                                //             ),
                                //           ),
                                //           suffixIcon: IconButton(
                                //             icon: Icon(
                                //               _isOscure
                                //                   ? Icons.visibility
                                //                   : Icons.visibility_off,
                                //               size: 16,
                                //             ),
                                //             onPressed: () => togle(),
                                //           ),
                                //           hintText:
                                //               "${AppLocalizations.of(context)!.translate('Password')}",
                                //           hintStyle: TextStyle(
                                //               fontFamily: content_font,
                                //               color: Colors.grey.shade500,
                                //               fontSize: 14)),
                                //     )),
                                Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      initialValue: creds['vpass'],
                                      onChanged: (value) {
                                        creds['vpass'] = value;
                                      },
                                      obscureText: _isOscure,
                                      style: const TextStyle(
                                          fontFamily: content_font,
                                          fontSize: 14),
                                      textAlign: TextAlign.start,
                                      cursorColor: blueColor,
                                      decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: blueColor,
                                              width: 2,
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isOscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              size: 16,
                                            ),
                                            onPressed: () => togle(),
                                          ),
                                          hintText:
                                              "${AppLocalizations.of(context)!.translate('Password')}",
                                          hintStyle: TextStyle(
                                              fontFamily: content_font,
                                              color: Colors.grey.shade500,
                                              fontSize: 14)),
                                    )),
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child:
                                                    Resset_Password_Verification()));

                                        /* Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Register())); // CodeEntry()));*/
                                      },
                                      child: Text(
                                          "${AppLocalizations.of(context)!.translate('resset')}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: content_font,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  blueColor.withOpacity(0.7)))),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Wrap(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: blueColor,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50)),
                                            onPressed: () {
                                              print(
                                                  "${AppLocalizations.of(context)!.translate('login')}");
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              Provider.of<AuthService>(context,
                                                      listen: false)
                                                  .login(creds)
                                                  .then((value) {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                if (value ==
                                                    "utilisateur non verifié") {
                                                  setState(() {
                                                    _isverify = true;
                                                  });
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    const CustomSnackBar.info(
                                                      message:
                                                          "Verifier votre compte !",
                                                    ),
                                                  );
                                                } else if (value ==
                                                    "Aucun utilisateur trouvé ou identifiant incorrect.") {
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    const CustomSnackBar.error(
                                                      message:
                                                          "Aucun utilisateur trouvé ou identifiant incorrect.",
                                                    ),
                                                  );
                                                } 
                                                else if (value ==
                                                    "Le mot de passe est incorrect!") {
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    const CustomSnackBar.error(
                                                      message:
                                                          "Le mot de passe est incorrect!",
                                                    ),
                                                  );
                                                } 
                                                else if (value ==
                                                    "Erreur interne du serveur.") {
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    const CustomSnackBar.error(
                                                      message:  "Erreur interne du serveur.",
                                                    ),
                                                  );
                                                } 
                                                else if (value ==
                                                    "Authentification réussie.") {
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    const CustomSnackBar
                                                        .success(
                                                      message: "Succes",
                                                    ),
                                                  );
                                                  if (widget.isLogin) {
                                                    Navigator.pop(context);
                                                    Navigator.pop(
                                                        widget.fatherContext!);
                                                  }
                                                }
                                              }
                                              ).catchError((error) {
                                                print(" hmmmmm $error");
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                showTopSnackBar(
                                                  Overlay.of(context),
                                                  CustomSnackBar.error(
                                                    message:
                                                        "${AppLocalizations.of(context)!.translate('errorlogin')}",
                                                  ),
                                                );
                                              });
                                            },
                                            child: Text(
                                              "${AppLocalizations.of(context)!.translate('Valider')}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
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
                          const SizedBox(
                            height: 35,
                          ),
                          Container(
                            child: GestureDetector(
                                onTap: () {
                                  setRegister();
                                  /* Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Register())); // CodeEntry()));*/
                                },
                                child: Text(
                                    "${AppLocalizations.of(context)!.translate('create')}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: content_font,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: blueColor))),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                    child:
                                        Container(height: 2, color: blueColor)),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                      "${AppLocalizations.of(context)!.translate('Ou')}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: content_font,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                                Expanded(
                                    child:
                                        Container(height: 2, color: blueColor))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          InkWell(
                            onTap: () async {
                              final LocalAuthentication auth =
                                  LocalAuthentication();
                              final bool canAuthenticateWithBiometrics =
                                  await auth.canCheckBiometrics;
                              final bool canAuthenticate =
                                  canAuthenticateWithBiometrics ||
                                      await auth.isDeviceSupported();
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();

                              if (pref.getString("tel") != null &&
                                  canAuthenticate) {
                                final bool didAuthenticate = await auth
                                    .authenticate(
                                        localizedReason:
                                            'Please authenticate to show account balance',
                                        options: const AuthenticationOptions(
                                            biometricOnly: true),
                                        authMessages: <AuthMessages>[
                                      const AndroidAuthMessages(
                                        signInTitle:
                                            'Oops! L authentification Biometrique est requise pour cette fonctionalite!',
                                        cancelButton: 'Fermer',
                                      ),
                                      const IOSAuthMessages(
                                        cancelButton: 'No thanks',
                                      ),
                                    ]);
                                if (didAuthenticate) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  context
                                      .read<AuthService>()
                                      .loginWithBiometric(
                                          {"id": pref.getString("tel")}).then(
                                    (value) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      if (value == "NotVerified") {
                                        setState(() {
                                          _isverify = true;
                                        });
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          CustomSnackBar.success(
                                            message:
                                                "$value verifier votre compte",
                                          ),
                                        );
                                      }
                                      if (value ==
                                          "Authentification réussie.") {
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          CustomSnackBar.success(
                                            message: value.toString(),
                                          ),
                                        );
                                        if (widget.isLogin) {
                                          Navigator.pop(context);
                                          Navigator.pop(widget.fatherContext!);
                                        }
                                      }
                                    },
                                  ).catchError((error) {
                                    print(" hmmmmm $error");
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                        message: error.toString(),
                                      ),
                                    );
                                  });
                                }
                              } else {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.info(
                                    maxLines: 3,
                                    message:
                                        "Veuillez vous connecter pour une première fois avec votre numero de telephone",
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.indigo.withOpacity(0.2),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ico-emprunte.png',
                                    width: 65,
                                  ),
                                  Text(
                                      "${AppLocalizations.of(context)!.translate('Scannez')}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: content_font,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        child: _isLoading
                            ? Loader(
                                color: blueColor,
                                loadingTxt:
                                    "${AppLocalizations.of(context)!.translate('loaderconex')}")
                            : Container())
                  ],
                ));
  }
}
