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
import 'package:mydirectcash/screens/transaction_new.dart';
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
  Widget buildTextField(BuildContext context, IconData icon, String labelKey) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Icon(icon),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: const TextStyle(fontFamily: content_font, fontSize: 13),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.translate(labelKey),
                labelStyle: TextStyle(
                  fontFamily: content_font,
                  color: Colors.grey.shade500,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordField(BuildContext context, String hintKey) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: const TextStyle(fontFamily: content_font, fontSize: 13),
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.visibility, size: 16),
          hintText: AppLocalizations.of(context)!.translate(hintKey),
          hintStyle: TextStyle(
            fontFamily: content_font,
            color: Colors.grey.shade500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingHeader() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        CircleAvatar(
          radius: 55.0,
          backgroundColor: Colors.white,
          backgroundImage:
              AssetImage('assets/images/logo-alliance-transparent.png'),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
      {required String icon,
      required String title,
      required Widget? nextPage}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      leading: SvgPicture.asset(
        "assets/svg/$icon.svg",
        height: 25,
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
      minLeadingWidth: 10,
      title: Text(title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                ),
              );
            },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthService>();
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.translate("Paramètres")!.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            _buildSettingHeader(),
            _buildSettingTile(
                icon: "home", title: "Accueil", nextPage: const Home()),
            _buildSettingTile(
              icon: "transaction",
              title: "Mes transactions",
              nextPage:
                  Transactions(phone: authProvider.currentUser?.data?.phone),
              // nextPage: TransactionNew(),
            ),
            _buildSettingTile(
                icon: "person",
                title: "Mon Compte",
                nextPage: const MonCompte()),
            _buildSettingTile(
                icon: "password",
                title: "Mes identifiants",
                nextPage: const AccountQR()),
            _buildSettingTile(
                icon: "pricing",
                title: "Tarif",
                nextPage: const Grille_Tarifaire()),
            _buildSettingTile(
                icon: "languages",
                title: "Langue",
                nextPage: const ChangeLanguagePage()),
            _buildSettingTile(
                icon: "help",
                title: "Aide et support",
                nextPage: const Support()),
            _buildSettingTile(
                icon: "about",
                title: "A propos de MyDirectCash",
                nextPage: const Apropos_de_nous()),
            _buildSettingTile(
                icon: "terms",
                title: "Conditions d'utilisation",
                nextPage: Cgu()),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              leading: SvgPicture.asset("assets/svg/share.svg",
                  height: 25,
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
              title: const Text("Partager",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final box = context.findRenderObject() as RenderBox?;
                await Share.share(
                    "https://play.google.com/store/apps/details?id=cm.directcash.alliancefinancialsa.mydirectcashmobile",
                    subject: "",
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              leading: SvgPicture.asset("assets/svg/log-out.svg",
                  height: 25,
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
              title: const Text("Se déconnecter",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Provider.of<AuthService>(context, listen: false).logout();
                Navigator.pop(context);
                Navigator.pop(context);
                // Navigator.pushNamed(context, AppRoutes.loginPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
