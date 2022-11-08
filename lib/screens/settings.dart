import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mydirectcash/AppLanguage.dart';
import 'package:mydirectcash/Controllers/UserController.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Apropos_de_nous.dart';
import 'package:mydirectcash/screens/En_sqvoir_plus.dart';
import 'package:mydirectcash/screens/Grille_Tarifaire.dart';
import 'package:mydirectcash/screens/Grille_Tarifaire_model.dart';
import 'package:mydirectcash/screens/MonCompte.dart';

import 'package:mydirectcash/screens/account_qr.dart';
import 'package:mydirectcash/screens/achat_credit.dart';
import 'package:mydirectcash/screens/aide_et_suport.dart';

import 'package:mydirectcash/screens/guichet_remplir_info.dart';
import 'package:mydirectcash/screens/om_momo.dart';
import 'package:mydirectcash/screens/payement_marchand.dart';
import 'package:mydirectcash/screens/simulateur_de_facture.dart';
import 'package:mydirectcash/screens/transactions.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/choix_envoi_argent.dart';
import 'package:mydirectcash/widgets/choix_facture_component.dart';
import 'package:mydirectcash/widgets/choix_recharge.dart';
import 'package:mydirectcash/widgets/settingstab_option.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget profilContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              children: [
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.person),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                labelText:
                                    "${AppLocalizations.of(context)!.translate('name')}",
                                labelStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey.shade500,
                                    fontSize: 13)),
                          ),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.phone),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                labelText:
                                    "${AppLocalizations.of(context)!.translate('Phone')}",
                                labelStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey.shade500,
                                    fontSize: 13)),
                          ),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.alternate_email),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                labelText:
                                    "${AppLocalizations.of(context)!.translate('email')}",
                                labelStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey.shade500,
                                    fontSize: 13)),
                          ),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.flag_outlined),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("pays")}",
                                labelStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey.shade500,
                                    fontSize: 13)),
                          ),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.location_on_outlined),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: content_font, fontSize: 13),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                labelText:
                                    "${AppLocalizations.of(context)!.translate("Ville de résidence")}",
                                labelStyle: TextStyle(
                                    fontFamily: content_font,
                                    color: Colors.grey.shade500,
                                    fontSize: 13)),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
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
                                primary: blueColor,
                                padding: EdgeInsets.symmetric(horizontal: 50)),
                            onPressed: () {},
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("Sauvegarder")}",
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
          // BottomNavigation()
        ],
      ),
    );
  }

  Widget settingsContent(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    final authProvider = context.watch<AuthService>();
    bool islanguage = false;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();

                    /*Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: GuichetRemplirInfos()));*/
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.home,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("Accueil")}"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: AchatCredit()));
                  },
                  child: SettingsTabOption(
                    icon: Image.asset(
                      color: Colors.black,
                      'assets/images/ico-achat-credit.png',
                      width: 20,
                    ),
                    title:
                        "${AppLocalizations.of(context)!.translate('Achat de crédit')}",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: PayementMarchand()));
                  },
                  child: SettingsTabOption(
                    icon: Image.asset(
                      'assets/images/ico-paiement-marchand.png',
                      width: 20,
                      color: Colors.black,
                    ),
                    title:
                        "${AppLocalizations.of(context)!.translate('Payement Marchand')}",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: OmMoMo()));
                  },
                  child: SettingsTabOption(
                    icon: Image.asset(
                      'assets/images/ico-om_momo.png',
                      width: 20,
                      color: Colors.black,
                    ),
                    title:
                        "${AppLocalizations.of(context)!.translate('ommom')}",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ChoixEnvoiArgent();
                        });
                  },
                  child: SettingsTabOption(
                    icon: Image.asset(
                      'assets/images/ico-transfert-dargent.png',
                      width: 20,
                      color: Colors.black,
                    ),
                    title:
                        "${AppLocalizations.of(context)!.translate('Envoi d\'argent')}",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ChoixFacture();
                        });
                  },
                  child: SettingsTabOption(
                    icon: Image.asset(
                      'assets/images/ico-facture.png',
                      width: 20,
                      color: Colors.black,
                    ),
                    title:
                        "${AppLocalizations.of(context)!.translate('Payement de facture')}",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Transactions(
                              phone: authProvider.currentUser!.data!.phone!,
                            )));
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("Mes transactions")}"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: MonCompte()));
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("Mon Compte")}"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: AccountQR()));
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("Mes identifiants")}"),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChoixRecharge();
                        });
                  },
                  child: SettingsTabOption(
                    icon: Icon(
                      Icons.chevron_right,
                      size: 18,
                    ),
                    title:
                        "${AppLocalizations.of(context)!.translate("Recharger mon compte")}",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Grille_Tarifaire_model()));
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("tarif")}"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Simulateur_de_facture()));
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("Simulation facture ENEO")}"),
                ),
                SettingsTabOption(
                    icon: Icon(
                      Icons.chevron_right,
                      size: 18,
                    ),
                    title:
                        "${AppLocalizations.of(context)!.translate("Guichet producteur")}"),
                GestureDetector(
                  onTap: () {
                    var link = "https://youtu.be/xtv7lspYRaA";
                    try {
                      launch(link);
                    } catch (e) {
                      //To handle error and display error message
                      showTopSnackBar(
                          context,
                          CustomSnackBar.error(
                            message: "Unable to open whatsapp",
                          ),
                          displayDuration: Duration(seconds: 2));
                    }
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("Comment ça marche ?")}"),
                ),
                InkWell(
                  onTap: () {
                    print("logout");
                    Provider.of<AuthService>(context, listen: false).logout();
                    Navigator.pop(context);
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.logout,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("Se déconnecter")}"),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      islanguage = !islanguage;
                    });
                    print(islanguage);
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("Langue")}"),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 8, left: 16),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            UserController().sharedPreferences().then((value) {
                              //  if (value.getString('language_code') != "en")
                              appLanguage.changeLanguage(const Locale("en"));
                            });
                          },
                          child: SettingsTabOption(
                              icon: Icon(
                                Icons.chevron_right,
                                size: 18,
                              ),
                              title:
                                  "${AppLocalizations.of(context)!.translate("Englais")}"),
                        ),
                        InkWell(
                          onTap: () {
                            UserController().sharedPreferences().then((value) {
                              //  if (value.getString('language_code') != "fr")
                              appLanguage.changeLanguage(const Locale("fr"));
                            });
                          },
                          child: SettingsTabOption(
                              icon: Icon(
                                Icons.chevron_right,
                                size: 18,
                              ),
                              title:
                                  "${AppLocalizations.of(context)!.translate("Francais")}"),
                        ),
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Support()));
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("Aide et support")}"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: En_sqvoir_plus()));
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("en savoir plus")}"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Apropos_de_nous()));
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("A propos de MyDirectCash")}"),
                ),
                GestureDetector(
                  onTap: () async {
                    final box = context.findRenderObject() as RenderBox?;

                    await Share.share(
                      "https://play.google.com/store/apps/details?id=cm.directcash.alliancefinancialsa.mydirectcashmobile",
                      subject: "",
                      sharePositionOrigin:
                          box!.localToGlobal(Offset.zero) & box.size,
                    );
                  },
                  child: SettingsTabOption(
                      icon: Icon(
                        Icons.share,
                        size: 20,
                      ),
                      title:
                          "${AppLocalizations.of(context)!.translate("Share")}"),
                )
              ],
            ),
          ),
          // BottomNavigation()
        ],
      ),
    );
  }

  Widget configPassWordContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              children: [
                Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.translate("Configurer son mot de passe")}",
                        style: TextStyle(
                            fontFamily: title_font,
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontFamily: content_font, fontSize: 13),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility,
                            size: 16,
                          ),
                          hintText:
                              "${AppLocalizations.of(context)!.translate("Ancien mot de passe")}",
                          hintStyle: TextStyle(
                              fontFamily: content_font,
                              color: Colors.grey.shade500,
                              fontSize: 13)),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontFamily: content_font, fontSize: 13),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility,
                            size: 16,
                          ),
                          hintText:
                              "${AppLocalizations.of(context)!.translate("Password")}",
                          hintStyle: TextStyle(
                              fontFamily: content_font,
                              color: Colors.grey.shade500,
                              fontSize: 13)),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontFamily: content_font, fontSize: 13),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility,
                            size: 16,
                          ),
                          hintText:
                              "${AppLocalizations.of(context)!.translate("Confirmer mot de passe")}",
                          hintStyle: TextStyle(
                              fontFamily: content_font,
                              color: Colors.grey.shade500,
                              fontSize: 13)),
                    )),
                SizedBox(
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
                                primary: blueColor,
                                padding: EdgeInsets.symmetric(horizontal: 50)),
                            onPressed: () {},
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("Sauvegarder")}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                          "${AppLocalizations.of(context)!.translate("annuler")}",
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
          //BottomNavigation()
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthService>().authenticate;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.cyan,
          toolbarHeight: 200,
          iconTheme: IconThemeData(color: blueColor, size: 40),
          title: Container(
            margin: EdgeInsets.only(right: 50),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 0),
                  child: Image.asset(
                    'assets/images/ico-avatar.png',
                    width: 130,
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            labelColor: blueColor,
            indicatorColor: blueColor,
            indicatorWeight: 2,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                  child: Text(
                      AppLocalizations.of(context)!
                          .translate("Paramètres")!
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: content_font,
                          fontWeight: FontWeight.w500))),
              /* Tab(
                  child: Text(
                AppLocalizations.of(context)!.translate("Profil")!.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontFamily: content_font, fontWeight: FontWeight.w500),
              )),*/
              /* Tab(
                  child: Text(
                      AppLocalizations.of(context)!
                          .translate("Password")!
                          .toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: content_font,
                          fontWeight: FontWeight.w500))),*/
            ],
          ),
        ),
        body: TabBarView(
          children: [
            settingsContent(context),
            // profilContent(context),
            // configPassWordContent(context),
          ],
        ),
      ),
    );
  }
}
