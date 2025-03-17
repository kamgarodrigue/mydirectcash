import 'package:flutter/material.dart';
import 'package:mydirectcash/screens/retrait_validation.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

class RetraitAmountSelection extends StatelessWidget {
  List? data;
  RetraitAmountSelection({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 246, 249, 1),
      appBar: AppBar(
        title: const Text("Selectionnez une transaction",
            style: TextStyle(fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  child: Column(
                    children: data!
                        .map(
                          (retrait) => GestureDetector(
                            onTap: () {
                              print("retrait: $retrait");
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: RetraitValidation(retrait: retrait),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: RetraitView(
                                retrait: retrait,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RetraitView extends StatelessWidget {
  final Map? retrait;
  const RetraitView({
    super.key,
    required this.retrait,
  });
 String formatDate(String dateString, {String? locale}) {
    DateTime date = DateTime.parse(dateString);

    // Use the provided locale or default to system locale
    String detectedLocale = locale ?? Intl.getCurrentLocale();

    return DateFormat("MMM dd, HH:mm", detectedLocale).format(date);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: 110,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromRGBO(178, 200, 233, 0.2),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/logo-alliance-transparent.png',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${retrait?['ToNumber']}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: blueColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${retrait?['SenderName']}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: blueColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${retrait?['Amount']} XAF",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  formatDate("${retrait?['CreatedAt']}"),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: blueColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
