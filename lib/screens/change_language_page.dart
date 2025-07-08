
import 'package:flutter/material.dart';
import 'package:mydirectcash/AppLanguage.dart';
import 'package:mydirectcash/Controllers/UserController.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  bool selected = false;
   late String selectedLanguage;

  @override
  void initState() {
    super.initState();

    final appLanguage = Provider.of<AppLanguage>(context, listen: false);
    selectedLanguage = appLanguage.appLocal.languageCode;
  }

   void updateLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }


  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    Widget buildLanguageTile({
      required String image,
      required String title,
      required bool isSelected,
      required Function() callback,
    }) {
      return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          leading: Image.asset(
            image,
            height: 50,
          ),
          minLeadingWidth: 10,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: 16,
                    color: blueColor,
                  )),
            ],
          ),
          trailing: Icon(
            isSelected == true ? Icons.check_circle : Icons.circle_outlined,
            size: 25,
            color: blueColor,
          ),
          onTap: () => callback());
    }

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
                      "${AppLocalizations.of(context)!.translate('Langue')}",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: title_font,
                          color: blueColor,
                          fontWeight: FontWeight.w500),
                    )
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
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    buildLanguageTile(
                      image: "assets/images/france.png",
                      title:
                          "${AppLocalizations.of(context)!.translate("Francais")}",
                      callback: () {
                        UserController().sharedPreferences().then((value) {
                          appLanguage.changeLanguage(const Locale("fr"));
                        });
                         updateLanguage("fr");

                      },
                     isSelected: selectedLanguage == "fr",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildLanguageTile(
                      image: "assets/images/england.png",
                      title:
                          "${AppLocalizations.of(context)!.translate("Englais")}",
                      callback: () {
                        UserController().sharedPreferences().then((value) {
                          appLanguage.changeLanguage(const Locale("en"));
                        });
                          updateLanguage("en");
                      },
                      isSelected: selectedLanguage == "en",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildLanguageTile(
                      image: "assets/images/spain.png",
                      title:
                          "${AppLocalizations.of(context)!.translate("Espagnol")}",
                      callback: () {
                        UserController().sharedPreferences().then((value) {
                          appLanguage.changeLanguage(const Locale("es"));
                        });
                         updateLanguage("es");
                      },
                      isSelected: selectedLanguage == "es",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
