import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/Transaction.dart';
import 'package:mydirectcash/Models/User.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:provider/provider.dart';

class LastTransaction extends StatefulWidget {
  User? currrentUser;
  LastTransaction({super.key, this.currrentUser});
  @override
  _LastTransactionState createState() => _LastTransactionState();
}

class _LastTransactionState extends State<LastTransaction> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context
    //     .read<TransactonService>()
    //     .getHistory(widget.currrentUser!.data!.phone);
  }

  @override
  Widget build(BuildContext context) {
    final transaction = context.watch<TransactonService>();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: blueColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(children: [
            Icon(Icons.chevron_right, size: 18, color: blueColor),
            Text(
              AppLocalizations.of(context)!
                  .translate("Dernières transactions")!,
              textAlign: TextAlign.start,
              style: TextStyle(
                  //fontSize: 12,
                  fontFamily: content_font,
                  color: blueColor),
            ),
          ]),
          const Padding(
            padding: EdgeInsets.only(left: 18, top: 5),
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            children: List.generate(
              transaction.historique.length,
              (index) => Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18, top: 0),
                          child: Text(
                            "${transaction.historique[index].typeOperation}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: content_font,
                            ),
                          ),
                        ),
                        Text(
                          "${transaction.historique[index].montant}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: content_font,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18, top: 0),
                          child: Text(
                            transaction.historique[index].collecteur!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: content_font,
                            ),
                          ),
                        ),
                        Text(
                          '${transaction.historique[index].jour}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily: content_font,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                  const Padding(
                    padding: EdgeInsets.only(left: 18, top: 5),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
