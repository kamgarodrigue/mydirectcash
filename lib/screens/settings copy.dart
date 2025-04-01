import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Apropos_de_nous.dart';
import 'package:mydirectcash/screens/Cgu.dart';
import 'package:mydirectcash/screens/En_sqvoir_plus.dart';
import 'package:mydirectcash/screens/Grille_Tarifaire.dart';
import 'package:mydirectcash/screens/MonCompte.dart';

import 'package:mydirectcash/screens/account_qr.dart';
import 'package:mydirectcash/screens/aide_et_suport.dart';
import 'package:mydirectcash/screens/change_language_page.dart';

import 'package:mydirectcash/screens/home.dart';
import 'package:mydirectcash/screens/transactions.dart';
import 'package:mydirectcash/utils/app_routes.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget profilContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
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
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.phone),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
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
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.alternate_email),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
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
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.flag_outlined),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
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
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.location_on_outlined),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
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
                                    const EdgeInsets.symmetric(horizontal: 50)),
                            onPressed: () {},
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("Sauvegarder")}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
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

  Widget _buildSettingHeader() {
    return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        height: 10,
      ),
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: null,
        child: CircleAvatar(
          radius: 55.0,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(
            'assets/images/logo-alliance-transparent.png',
          ),
        ),
      )
    ]);
  }

  Widget _buildSettingTile({
    required String icon,
    required String title,
    required Widget? nextPage,
  }) {
    final authProvider = context.watch<AuthService>();
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      leading: SvgPicture.asset(
        "assets/svg/$icon.svg",
        height: 25,
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
      minLeadingWidth: 10,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
      onTap: nextPage == null
          ? null
          : () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      nextPage,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
    );
  }

  void _logout() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: blueColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('...')
              ],
            ),
          ),
        );
      },
    );
    try {
      Provider.of<AuthService>(context, listen: false).logout();
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
    }
  }

  // Widget settingsContent(BuildContext context) {
  //   var appLanguage = Provider.of<AppLanguage>(context);
  //   final authProvider = context.watch<AuthService>();
  //   bool islanguage = false;
  //   return Container(
  //     height: MediaQuery.of(context).size.height,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: const BoxDecoration(
  //         image: DecorationImage(
  //             image: AssetImage('assets/images/background.png'),
  //             fit: BoxFit.cover)),
  //     child: Column(
  //       children: [
  //         Expanded(
  //           child: ListView(
  //             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
  //             children: [
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.of(context).pop();

  //                   /*Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: GuichetRemplirInfos()));*/
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.home,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("Accueil")}"),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: AchatCredit()));
  //                 },
  //                 child: SettingsTabOption(
  //                   icon: Image.asset(
  //                     color: Colors.black,
  //                     'assets/images/ico-achat-credit.png',
  //                     width: 20,
  //                   ),
  //                   title:
  //                       "${AppLocalizations.of(context)!.translate('Achat de crédit')}",
  //                 ),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: const PayementMarchand()));
  //                 },
  //                 child: SettingsTabOption(
  //                   icon: Image.asset(
  //                     'assets/images/ico-paiement-marchand.png',
  //                     width: 20,
  //                     color: Colors.black,
  //                   ),
  //                   title:
  //                       "${AppLocalizations.of(context)!.translate('Payement Marchand')}",
  //                 ),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: OmMoMo()));
  //                 },
  //                 child: SettingsTabOption(
  //                   icon: Image.asset(
  //                     'assets/images/ico-om_momo.png',
  //                     width: 20,
  //                     color: Colors.black,
  //                   ),
  //                   title:
  //                       "${AppLocalizations.of(context)!.translate('ommom')}",
  //                 ),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   showModalBottomSheet(
  //                       context: context,
  //                       builder: (BuildContext context) {
  //                         return ChoixEnvoiArgent();
  //                       });
  //                 },
  //                 child: SettingsTabOption(
  //                   icon: Image.asset(
  //                     'assets/images/ico-transfert-dargent.png',
  //                     width: 20,
  //                     color: Colors.black,
  //                   ),
  //                   title:
  //                       "${AppLocalizations.of(context)!.translate('Envoi d\'argent')}",
  //                 ),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   showModalBottomSheet(
  //                       context: context,
  //                       builder: (BuildContext context) {
  //                         return ChoixFacture();
  //                       });
  //                 },
  //                 child: SettingsTabOption(
  //                   icon: Image.asset(
  //                     'assets/images/ico-facture.png',
  //                     width: 20,
  //                     color: Colors.black,
  //                   ),
  //                   title:
  //                       "${AppLocalizations.of(context)!.translate('Payement de facture')}",
  //                 ),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: Transactions(
  //                             phone: authProvider.currentUser!.data!.phone!,
  //                           )));
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("Mes transactions")}"),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: MonCompte()));
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("Mon Compte")}"),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: AccountQR()));
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("Mes identifiants")}"),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   showDialog(
  //                       context: context,
  //                       builder: (BuildContext context) {
  //                         return ChoixRecharge();
  //                       });
  //                 },
  //                 child: SettingsTabOption(
  //                   icon: const Icon(
  //                     Icons.chevron_right,
  //                     size: 18,
  //                   ),
  //                   title:
  //                       "${AppLocalizations.of(context)!.translate("Recharger mon compte")}",
  //                 ),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: Grille_Tarifaire()));
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("tarif")}"),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: Simulateur_de_facture()));
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("Simulation facture ENEO")}"),
  //               ),
  //               /* SettingsTabOption(
  //                   icon: Icon(
  //                     Icons.chevron_right,
  //                     size: 18,
  //                   ),
  //                   title:
  //                       "${AppLocalizations.of(context)!.translate("Guichet producteur")}"),
  //               GestureDetector(
  //                 onTap: () {
  //                   var link = "https://youtu.be/xtv7lspYRaA";
  //                   try {
  //                     launch(link);
  //                   } catch (e) {
  //                     //To handle error and display error message
  //                     showTopSnackBar(
  //                         context,
  //                         CustomSnackBar.error(
  //                           message: "Unable to open whatsapp",
  //                         ),
  //                         displayDuration: Duration(seconds: 2));
  //                   }
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("Comment ça marche ?")}"),
  //               ),
  //           */
  //               InkWell(
  //                 onTap: () {
  //                   print("logout");
  //                   Provider.of<AuthService>(context, listen: false).logout();
  //                   Navigator.pop(context);
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.logout,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("Se déconnecter")}"),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     islanguage = !islanguage;
  //                   });
  //                   print(islanguage);
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("Langue")}"),
  //               ),
  //               Padding(
  //                   padding: const EdgeInsets.only(top: 8, left: 16),
  //                   child: Column(
  //                     children: [
  //                       InkWell(
  //                         onTap: () {
  //                           UserController().sharedPreferences().then((value) {
  //                             //  if (value.getString('language_code') != "en")
  //                             appLanguage.changeLanguage(const Locale("en"));
  //                           });
  //                         },
  //                         child: SettingsTabOption(
  //                             icon: const Icon(
  //                               Icons.chevron_right,
  //                               size: 18,
  //                             ),
  //                             title:
  //                                 "${AppLocalizations.of(context)!.translate("Englais")}"),
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           UserController().sharedPreferences().then((value) {
  //                             //  if (value.getString('language_code') != "fr")
  //                             appLanguage.changeLanguage(const Locale("es"));
  //                           });
  //                         },
  //                         child: SettingsTabOption(
  //                             icon: const Icon(
  //                               Icons.chevron_right,
  //                               size: 18,
  //                             ),
  //                             title:
  //                                 "${AppLocalizations.of(context)!.translate("Espagnol")}"),
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           UserController().sharedPreferences().then((value) {
  //                             //  if (value.getString('language_code') != "fr")
  //                             appLanguage.changeLanguage(const Locale("fr"));
  //                           });
  //                         },
  //                         child: SettingsTabOption(
  //                             icon: const Icon(
  //                               Icons.chevron_right,
  //                               size: 18,
  //                             ),
  //                             title:
  //                                 "${AppLocalizations.of(context)!.translate("Francais")}"),
  //                       ),
  //                     ],
  //                   )),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: Support()));
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("Aide et support")}"),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: En_sqvoir_plus()));
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("en savoir plus")}"),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: Apropos_de_nous()));
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("A propos de MyDirectCash")}"),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       PageTransition(
  //                           type: PageTransitionType.rightToLeft,
  //                           child: Cgu()));
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.chevron_right,
  //                       size: 18,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("utilisation")}"),
  //               ),
  //               GestureDetector(
  //                 onTap: () async {
  //                   final box = context.findRenderObject() as RenderBox?;

  //                   await Share.share(
  //                     "https://play.google.com/store/apps/details?id=cm.directcash.alliancefinancialsa.mydirectcashmobile",
  //                     subject: "",
  //                     sharePositionOrigin:
  //                         box!.localToGlobal(Offset.zero) & box.size,
  //                   );
  //                 },
  //                 child: SettingsTabOption(
  //                     icon: const Icon(
  //                       Icons.share,
  //                       size: 20,
  //                     ),
  //                     title:
  //                         "${AppLocalizations.of(context)!.translate("Share")}"),
  //               )
  //             ],
  //           ),
  //         ),
  //         // BottomNavigation()
  //       ],
  //     ),
  //   );
  // }

  Widget configPassWordContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          fontFamily: content_font, fontSize: 13),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
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
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          fontFamily: content_font, fontSize: 13),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
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
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          fontFamily: content_font, fontSize: 13),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
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
                                    const EdgeInsets.symmetric(horizontal: 50)),
                            onPressed: () {},
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("Sauvegarder")}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
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
    final authProvider = context.watch<AuthService>();

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          title: Text(
              AppLocalizations.of(context)!.translate("Paramètres")!.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 24)),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover)),
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSettingHeader(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: Text(
                          AppLocalizations.of(context)!
                              .translate("Paramètres")!
                              .toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                    ),
                    _buildSettingTile(
                      icon: "home",
                      title:
                          "${AppLocalizations.of(context)!.translate("Accueil")}",
                      nextPage: const Home(),
                    ),
                    _buildSettingTile(
                      icon: "transaction",
                      title:
                          "${AppLocalizations.of(context)!.translate("Mes transactions")}",
                      nextPage: Transactions(
                        phone: authProvider.currentUser?.data?.phone,
                      ),
                    ),
                    _buildSettingTile(
                      icon: "person",
                      title:
                          "${AppLocalizations.of(context)!.translate("Mon Compte")}",
                      nextPage: const MonCompte(),
                    ),
                    _buildSettingTile(
                      icon: "password",
                      title:
                          "${AppLocalizations.of(context)!.translate("Mes identifiants")}",
                      nextPage: const AccountQR(),
                    ),
                    _buildSettingTile(
                      icon: "pricing",
                      title:
                          "${AppLocalizations.of(context)!.translate("tarif")}",
                      nextPage: const Grille_Tarifaire(),
                    ),
                    _buildSettingTile(
                      icon: "languages",
                      title:
                          "${AppLocalizations.of(context)!.translate("Langue")}",
                      nextPage: const ChangeLanguagePage(),
                    ),
                    _buildSettingTile(
                      icon: "help",
                      title:
                          "${AppLocalizations.of(context)!.translate("Aide et support")}",
                      nextPage: const Support(),
                    ),
                    _buildSettingTile(
                      icon: "more",
                      title:
                          "${AppLocalizations.of(context)!.translate("en savoir plus")}",
                      nextPage: const En_sqvoir_plus(),
                    ),
                    _buildSettingTile(
                      icon: "about",
                      title:
                          "${AppLocalizations.of(context)!.translate("A propos de MyDirectCash")}",
                      nextPage: const Apropos_de_nous(),
                    ),
                    _buildSettingTile(
                      icon: "terms",
                      title:
                          "${AppLocalizations.of(context)!.translate("utilisation")}",
                      nextPage: Cgu(),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 0.0),
                      leading: SvgPicture.asset(
                        "assets/svg/share.svg",
                        height: 25,
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.srcIn),
                      ),
                      minLeadingWidth: 10,
                      title: Text(
                          "${AppLocalizations.of(context)!.translate("Share")}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onTap: () => () async {
                        final box = context.findRenderObject() as RenderBox?;

                        await Share.share(
                          "https://play.google.com/store/apps/details?id=cm.directcash.alliancefinancialsa.mydirectcashmobile",
                          subject: "",
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size,
                        );
                      },
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 0.0),
                      leading: SvgPicture.asset(
                        "assets/svg/log-out.svg",
                        height: 25,
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.srcIn),
                      ),
                      minLeadingWidth: 10,
                      title: Text(
                          "${AppLocalizations.of(context)!.translate("Se déconnecter")}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onTap: () {
                        Provider.of<AuthService>(context, listen: false)
                            .logout();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.loginPage);
                      },
                    ),
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
