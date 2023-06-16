import 'package:flutter/material.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/screens/carousel_page.dart';

import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/bottom_navigation.dart';
import 'package:mydirectcash/widgets/delete_component.dart';
import 'package:mydirectcash/widgets/share_component.dart';
import 'package:mydirectcash/widgets/transaction_container.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Transactions extends StatefulWidget {
  final phone;
  Transactions({required this.phone});
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  bool rechargeModule = true;
  bool servicesModule = false;

  bool envoiModule = false;

  bool airtimeModule = false;
  bool om_momoModule = false;

  bool payementModule = false;

/*List<Map> transactions = [
    {
      'title': 'Dépôt OM',
      'destinataire': 'De TALLA jean (6 55 ** ** **)',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF',
    },
    {
      'title': 'Dépôt OM',
      'destinataire': 'De TALLA jean (6 55 ** ** **)',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF'
    },
    {
      'title': 'Dépôt OM',
      'destinataire': 'De TALLA jean (6 55 ** ** **)',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF'
    },
    {
      'title': 'Dépôt OM',
      'destinataire': 'De TALLA jean (6 55 ** ** **)',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF'
    },
    {
      'title': 'Dépôt OM',
      'destinataire': 'De TALLA jean (6 55 ** ** **)',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF'
    },
    {
      'title': 'Dépôt OM',
      'destinataire': 'De TALLA jean (6 55 ** ** **)',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF'
    },
    {
      'title': 'Dépôt OM',
      'destinataire': 'De TALLA jean (6 55 ** ** **)',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF'
    },
    {
      'title': 'Dépôt OM',
      'destinataire': 'De TALLA jean (6 55 ** ** **)',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF'
    },
    {
      'title': 'Dépôt OM',
      'destinataire': 'De TALLA jean (6 55 ** ** **)',
      'stringPrice': '20 000,0 XAF',
      'stringDate': 'Lun 22/05/21 - 15:20',
      'stringSolde': 'Solde : 15 000,0 XAF'
    },
  ];*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TransactonService>().getHistory(widget.phone);
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactonService>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              size: 20,
                            )),
                        Container(
                          width: 40,
                          height: 60,
                          color: Colors.transparent,
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
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 00,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Liste des transactions',
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 14,
                          fontFamily: title_font),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: blueColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(
                                            fontFamily: content_font,
                                            fontSize: 14),
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Rechercher',
                                            hintStyle: TextStyle(
                                                fontFamily: content_font,
                                                color: Colors.grey.shade500,
                                                fontSize: 14)))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: DropdownButton<String>(
                            isExpanded: false,
                            underline: Container(),
                            icon: Image.asset(
                              'assets/images/ico-filtre.png',
                              width: 25,
                            ),
                            items: <String>[
                              'Ce Jour',
                              'Cette Semaine',
                              'Ce Mois',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: new TextStyle(
                                    fontFamily: content_font,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              print(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rechargeModule = true;
                              servicesModule = false;
                              envoiModule = false;
                              airtimeModule = false;
                              om_momoModule = false;
                              payementModule = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: rechargeModule ? blueColor : Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            width: MediaQuery.of(context).size.width / 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ico-achat-credit.png',
                                  width: 30,
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                Text(
                                  "Recharge",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: content_font,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rechargeModule = false;
                              servicesModule = true;
                              envoiModule = false;
                              airtimeModule = false;
                              om_momoModule = false;
                              payementModule = false;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: servicesModule ? blueColor : Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            width: MediaQuery.of(context).size.width / 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ico-paiement-marchand.png',
                                  width: 30,
                                ),
                                Text(
                                  "Services",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: content_font,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rechargeModule = false;
                              servicesModule = false;
                              envoiModule = true;
                              airtimeModule = false;
                              om_momoModule = false;
                              payementModule = false;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: envoiModule ? blueColor : Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            width: MediaQuery.of(context).size.width / 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ico-transfert-dargent.png',
                                  width: 30,
                                ),
                                Text(
                                  "Envoi",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: content_font,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rechargeModule = false;
                              servicesModule = false;
                              envoiModule = false;
                              airtimeModule = true;
                              om_momoModule = false;
                              payementModule = false;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: airtimeModule ? blueColor : Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            width: MediaQuery.of(context).size.width / 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ico-achat-credit.png',
                                  width: 30,
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                Text(
                                  "Airtime",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: content_font,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rechargeModule = false;
                              servicesModule = false;
                              envoiModule = false;
                              airtimeModule = false;
                              om_momoModule = true;
                              payementModule = false;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: om_momoModule ? blueColor : Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            width: MediaQuery.of(context).size.width / 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ico-om_momo.png',
                                  width: 30,
                                ),
                                Text(
                                  "OM/MoMo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: content_font,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rechargeModule = false;
                              servicesModule = false;
                              envoiModule = false;
                              airtimeModule = false;
                              om_momoModule = false;
                              payementModule = true;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 10),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: payementModule ? blueColor : Colors.grey,
                                borderRadius: BorderRadius.circular(5)),
                            width: MediaQuery.of(context).size.width / 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/ico-facture.png',
                                  width: 30,
                                ),
                                Text(
                                  "Facture",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: content_font,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: transactionProvider.historique.length,
                    itemBuilder: (BuildContext context, int index) {
                      final transaction = transactionProvider.historique[index];

                      return TransactionContrainer(
                        destinataire:
                            '(${transactionProvider.historique[index].collecteur!.substring(0, 3)})',
                        title: transaction.typeOperation!,
                        stringDate: transaction.jour!,
                        stringPrice: transaction.montant!,
                        stringSolde: transaction.statut!,
                        onPressShare: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return ShareComponent();
                              });
                        },
                        onPressDelete: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteComponent();
                              });
                        },
                      );
                    }),
              ),
            ),
            BottomNavigation()
          ],
        ),
      ),
    );
  }
}
