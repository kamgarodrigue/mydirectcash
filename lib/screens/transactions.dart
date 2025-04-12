import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';

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
  const Transactions({super.key, required this.phone});
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  bool rechargeModule = true;
  bool servicesModule = false;
  bool isLoading = false;

  bool envoiModule = false;

  bool airtimeModule = false;
  bool om_momoModule = false;

  bool payementModule = false;
  Map data = {"userID": "", "vtrxType": "", "vfromdate": "", "vTodate": ""};
  String selectedPeriod = 'Ce Jour';
  late String startDate;
  late String endDate;
  List<dynamic> transactions = [];

  void loadTransactions() async {
    await TransactonService().getHistory(data).then((value) {
      setState(() {
        transactions = value['data'];
      });
      print(
          "=================================transactions=============================");
      print(transactions);
    });
  }

  @override
  void initState() {
    super.initState();
    data["userID"] = widget.phone;
    data["vtrxType"] = "";
    _updateDateRange(); // Initialize date range
    loadTransactions();
  }

  void _updateDateRange() {
    DateTime today = DateTime.now();
    DateTime start;
    DateTime? end;

    switch (selectedPeriod) {
      case 'Ce Jour': // Today's date
        start = today;
        end = null;
        break;

      case 'Cette Semaine': // Current week's Monday to Sunday
        start = today.subtract(Duration(days: today.weekday - 1)); // Monday
        end = start.add(const Duration(days: 6)); // Sunday
        break;

      case 'Ce Mois': // First and last day of current month
        start = DateTime(today.year, today.month, 1); // First day
        end = DateTime(today.year, today.month + 1, 0); // Last day
        break;

      case 'Cette Année': // First and last day of the year
        start = DateTime(today.year, 1, 1); // Jan 1st
        end = DateTime(today.year, 12, 31); // Dec 31st
        break;

      default:
        start = today;
        end = today;
    }

    setState(() {
      startDate = DateFormat('yyyy-MM-dd').format(start);
      endDate = end != null ? DateFormat('yyyy-MM-dd').format(end) : "";
      data["vfromdate"] = startDate;
      data["vTodate"] = endDate;
    });

    print("Start Date: $startDate");
    print("End Date: $endDate");
    loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
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
                  const SizedBox(
                    height: 00,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Liste des transactions',
                      style: TextStyle(
                          color: blueColor,
                          fontSize: 14,
                          fontFamily: title_font),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: blueColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
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
                        const SizedBox(
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
                              'Cette Année',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontFamily: content_font,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedPeriod = value!;
                                _updateDateRange();
                              });
                              context
                                  .read<TransactonService>()
                                  .getHistory(data)
                                  .then((value) {
                                print(value[1]);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             rechargeModule = true;
                  //             servicesModule = false;
                  //             envoiModule = false;
                  //             airtimeModule = false;
                  //             om_momoModule = false;
                  //             payementModule = false;
                  //           });
                  //         },
                  //         child: Container(
                  //           padding: const EdgeInsets.symmetric(vertical: 5),
                  //           margin: const EdgeInsets.only(left: 10),
                  //           decoration: BoxDecoration(
                  //               color: rechargeModule ? blueColor : Colors.grey,
                  //               borderRadius: BorderRadius.circular(5)),
                  //           width: MediaQuery.of(context).size.width / 5,
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Image.asset(
                  //                 'assets/images/ico-achat-credit.png',
                  //                 width: 30,
                  //               ),
                  //               const SizedBox(
                  //                 height: 0,
                  //               ),
                  //               const Text(
                  //                 "Recharge",
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                     fontFamily: content_font,
                  //                     fontSize: 10,
                  //                     color: Colors.white),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       rechargeModule = false;
                        //       servicesModule = true;
                        //       envoiModule = false;
                        //       airtimeModule = false;
                        //       om_momoModule = false;
                        //       payementModule = false;
                        //     });
                        //   },
                        //   child: Container(
                        //     margin: const EdgeInsets.only(left: 20),
                        //     padding: const EdgeInsets.symmetric(vertical: 5),
                        //     decoration: BoxDecoration(
                        //         color: servicesModule ? blueColor : Colors.grey,
                        //         borderRadius: BorderRadius.circular(5)),
                        //     width: MediaQuery.of(context).size.width / 5,
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Image.asset(
                        //           'assets/images/ico-paiement-marchand.png',
                        //           width: 30,
                        //         ),
                        //         const Text(
                        //           "Services",
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //               fontFamily: content_font,
                        //               fontSize: 10,
                        //               color: Colors.white),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       rechargeModule = false;
                        //       servicesModule = false;
                        //       envoiModule = true;
                        //       airtimeModule = false;
                        //       om_momoModule = false;
                        //       payementModule = false;
                        //     });
                        //   },
                        //   child: Container(
                        //     margin: const EdgeInsets.only(left: 20),
                        //     padding: const EdgeInsets.symmetric(vertical: 5),
                        //     decoration: BoxDecoration(
                        //         color: envoiModule ? blueColor : Colors.grey,
                        //         borderRadius: BorderRadius.circular(5)),
                        //     width: MediaQuery.of(context).size.width / 5,
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Image.asset(
                        //           'assets/images/ico-transfert-dargent.png',
                        //           width: 30,
                        //         ),
                        //         const Text(
                        //           "Envoi",
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //               fontFamily: content_font,
                        //               fontSize: 10,
                        //               color: Colors.white),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       rechargeModule = false;
                        //       servicesModule = false;
                        //       envoiModule = false;
                        //       airtimeModule = true;
                        //       om_momoModule = false;
                        //       payementModule = false;
                        //     });
                        //   },
                        //   child: Container(
                        //     margin: const EdgeInsets.only(left: 20),
                        //     padding: const EdgeInsets.symmetric(vertical: 5),
                        //     decoration: BoxDecoration(
                        //         color: airtimeModule ? blueColor : Colors.grey,
                        //         borderRadius: BorderRadius.circular(5)),
                        //     width: MediaQuery.of(context).size.width / 5,
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Image.asset(
                        //           'assets/images/ico-achat-credit.png',
                        //           width: 30,
                        //         ),
                        //         const SizedBox(
                        //           height: 0,
                        //         ),
                        //         const Text(
                        //           "Airtime",
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //               fontFamily: content_font,
                        //               fontSize: 10,
                        //               color: Colors.white),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       rechargeModule = false;
                        //       servicesModule = false;
                        //       envoiModule = false;
                        //       airtimeModule = false;
                        //       om_momoModule = true;
                        //       payementModule = false;
                        //     });
                        //   },
                        //   child: Container(
                        //     margin: const EdgeInsets.only(left: 20),
                        //     padding: const EdgeInsets.symmetric(vertical: 5),
                        //     decoration: BoxDecoration(
                        //         color: om_momoModule ? blueColor : Colors.grey,
                        //         borderRadius: BorderRadius.circular(5)),
                        //     width: MediaQuery.of(context).size.width / 5,
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Image.asset(
                        //           'assets/images/ico-om_momo.png',
                        //           width: 30,
                        //         ),
                        //         const Text(
                        //           "OM/MoMo",
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //               fontFamily: content_font,
                        //               fontSize: 10,
                        //               color: Colors.white),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       rechargeModule = false;
                        //       servicesModule = false;
                        //       envoiModule = false;
                        //       airtimeModule = false;
                        //       om_momoModule = false;
                        //       payementModule = true;
                        //     });
                        //   },
                        //   child: Container(
                        //     margin: const EdgeInsets.only(left: 20, right: 10),
                        //     padding: const EdgeInsets.symmetric(vertical: 5),
                        //     decoration: BoxDecoration(
                        //         color: payementModule ? blueColor : Colors.grey,
                        //         borderRadius: BorderRadius.circular(5)),
                        //     width: MediaQuery.of(context).size.width / 5,
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Image.asset(
                        //           'assets/images/ico-facture.png',
                        //           width: 30,
                        //         ),
                        //         const Text(
                        //           "Facture",
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //               fontFamily: content_font,
                        //               fontSize: 10,
                        //               color: Colors.white),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      // ],
                    // ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: blueColor),
                    )
                  : ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        final transaction = transactions[index];
                        return TransactionContrainer(
                          destinataire:
                              '(${transaction["TO_NUMBER"] ?? transaction["FROM_NUMBER"]})',
                          title: transaction["TRX_Type"],
                          stringDate: transaction["TRX_DATE"] != null
                              ? DateFormat('yyyy-MM-dd').format(
                                  DateTime.parse(transaction["TRX_DATE"]))
                              : "N/A",
                          stringPrice: transaction["Amount"],
                          stringSolde: transaction["TRX_Status"],
                          frais: transaction["rate"] ?? " ",
                        );
                      },
                    ),
            ),
            const BottomNavigation()
          ],
        ),
      ),
    );
  }
}
