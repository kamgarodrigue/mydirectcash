import 'package:flutter/material.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';

class Apropos_de_nous extends StatefulWidget {
  const Apropos_de_nous({Key? key}) : super(key: key);

  @override
  State<Apropos_de_nous> createState() => _Apropos_de_nousState();
}

class _Apropos_de_nousState extends State<Apropos_de_nous> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover)),
          child: ListView(children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
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
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                  "Alliance Financial Cameroun S.A. est une Société de Transfert d’Argent, intégrateur etéditeur de solutions financières mobile et de Change, agréée par arrête N°00000086/MINFI/SG/DGTCFM du 17 avril 2012, au Capital de FCFA 350 millions dont le siège social est à Buéa, et la Direction Générale à Yaoundé, B.P. 6068, immatriculée au Registre de Commerce et de Crédit Mobilier sous le numéro 2C/BUA/2009/B/045 du 15 juin2009 modifiée en RC.BUA.2009.B.045.G.001.2020 le 02-12-2020.\n\nAlliance Financial Cameroun S.A est éditeur et concepteur, développeur, agrégateur,intégrateur et propriétaire de la plateforme de logiciels, interopérable (tous réseaux) deservices financiers par mobile dénommée « Direct Cash » qui se décline en deux applicationsmobile money :\n\n• Un module pour Business ou professionnels (DirectCash Mobile) vers client tierce\n• Un module pour les particuliers (MyDirectCash mobile) ou compte à compte\n\nLes deux applications de l’écosystème Directcash (DirectCash Mobile et MyDirectCashMobile), téléchargeables sur Internet (Play store et App Store), porte-monnaie virtuel et transfert d’argent offre une gamme de produits et services qui répondent favorablement aux besoins des populations et particulièrement les populations des zones rurales et péri-urbaineset à tous les membres de la diaspora.",
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: title_font,
                      color: blueColor,
                      fontWeight: FontWeight.w500)),
            )
          ])),
    );
  }
}
