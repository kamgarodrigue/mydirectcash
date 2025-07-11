import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/User.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/screens/payement_facture_validate_new.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PayementFactureSelection extends StatefulWidget {
  List? data;
  final Map billType;
  PayementFactureSelection({super.key, this.data, required this.billType});

  @override
  State<PayementFactureSelection> createState() =>
      _PayementFactureSelectionState();
}

class _PayementFactureSelectionState extends State<PayementFactureSelection> {
  bool _isLoading = false;
  Map? param;
  Map? formData;

  @override
  void initState() {
    super.initState();
    context.read<AuthService>().authenticate;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = context.watch<AuthService>().currentUser;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 246, 249, 1),
      appBar: AppBar(
        title: const Text("Selectionnez une Facture",
            style: TextStyle(fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Column(
                        children: widget.data!
                            .map(
                              (bill) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isLoading = true;
                                    formData = {
                                      "agentID": user!.data?.phone,
                                      "amount": bill['amountLocalCur'],
                                      "paymentId": bill['payItemId'],
                                      "TRX_Type": widget.billType['id'],
                                      "email": user.data?.email,
                                      "numero": user.data?.phone,
                                      "serviceNumber":
                                          widget.billType['serviceNumber'],
                                    };

                                    param = {
                                      "amount": bill['amountLocalCur'],
                                      "to": "8768796765",
                                      "transactionType": widget.billType['id'],
                                    };
                                  });
                                  TransactonService()
                                      .getDetailEnvoiDirectcash(param)
                                      .then((value) {
                                    print(value);
                                    formData?["vNomalrate"] =
                                        value["data"]['Normalrate'];
                                    formData?["vDisplayraterate"] =
                                        value["data"]['DisplayRate'];
                                    print(formData);

                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return PayementFactureValidateNew(
                                          factureInfos: widget.billType,
                                          detailFac: bill,
                                          formData: formData,
                                        );
                                      },
                                    ));
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: RetraitView(
                                    bill: bill,
                                    info: widget.billType,
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
          Container(
              child: _isLoading ? const Loader(loadingTxt: '') : Container())
        ],
      ),
    );
  }
}

class RetraitView extends StatelessWidget {
  final Map? bill;
  final Map? info;
  const RetraitView({
    super.key,
    required this.bill,
    required this.info,
  });
  String formatDate(String dateString, {String? locale}) {
    DateTime date = DateTime.parse(dateString).toLocal();
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
              offset: const Offset(0, 3),
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
                image: DecorationImage(
                  image: AssetImage(
                    info?["image"] != null
                        ? info!["image"]
                        : 'assets/images/logo-alliance-transparent.png',
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
                  "${bill?['amountLocalCur']}XAF",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: blueColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${bill?['billNumber']}",
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
                  formatDate("${bill?['billDate']}"),
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
