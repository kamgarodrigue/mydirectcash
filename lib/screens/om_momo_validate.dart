import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/screens/widgets/dialog_widget.dart';
import 'package:mydirectcash/utils/app_routes.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class OmMoValidate extends StatefulWidget {
  final Map? data;
  final Map? param;
  final String fees;
  final String receiver;
  const OmMoValidate({
    super.key,
    this.data,
    this.param,
    required this.fees,
    required this.receiver,
  });

  @override
  _OmMoValidateState createState() => _OmMoValidateState();
}

class _OmMoValidateState extends State<OmMoValidate> {
  bool _isLoading = false;
  bool _isOscure = true;
  final TextEditingController _controller = TextEditingController();

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
    _controller.dispose();
    super.dispose();
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
                    keyboardType: TextInputType.number,
                    obscureText: _isOscure,
                    // initialValue: data["vPIN"],
                    onChanged: (value) {
                      setState(() {
                        widget.data?["vPIN"] = value;
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
                      widget.data?["vClientID"] =
                          autProvider.currentUser!.data!.phone;
                      print(widget.data);
                      TransactonService().achatCredit(widget.data).then((value) {
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
                            callback: () {
                              Navigator.pop(context);
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.homePage,
                                (route) => false,
                              );
                            },
                          );
                        } else if (value["code"] == 400) {
                          if (value["message"] ==
                              "L'API externe a retourné une réponse inattendue.") {
                            DialogWidget.success(
                              context,
                              title: AppLocalizations.of(context)!
                                  .translate("erreur")!,
                              content: AppLocalizations.of(context)!
                                  .translate("check_network_or_number"),
                              color: errorColor,
                              callback: () => Navigator.pop(context),
                            );
                          } else {
                            DialogWidget.success(
                              context,
                              title: AppLocalizations.of(context)!
                                  .translate("erreur")!,
                              content: value["message"],
                              color: errorColor,
                              callback: () => Navigator.pop(context),
                            );
                          }
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
    // final size = MediaQuery.of(context).size;
    String raw =
        AppLocalizations.of(context)!.translate("deposit_message") ?? "";
    String message = raw
        .replaceAll("{amount}", widget.data?['vAmount'])
        .replaceAll("{number}", widget.data?['vToNumber'])
        .replaceAll("{fee}", widget.fees);
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
                          Text(
                            'OM / MoMo',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: title_font,
                              color: blueColor,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontFamily: content_font,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  
                   
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    depot()
                  ],
                )),
            Container(
                child: _isLoading
                    ? Loader(
                        loadingTxt: '',
                        color: blueColor,
                      )
                    : Container())
          ],
        ));
  }
}
