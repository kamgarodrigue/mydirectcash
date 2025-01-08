import 'package:flutter/material.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';

class TransactionContrainer extends StatefulWidget {
  TransactionContrainer(
      {super.key, required this.destinataire,
      required this.title,
      required this.stringDate,
      required this.stringPrice,
      required this.stringSolde,
      required this.onPressShare,
      required this.onPressDelete});
  String title, destinataire, stringDate, stringPrice, stringSolde;
  void Function() onPressShare;
  void Function() onPressDelete;

  @override
  _TransactionContrainerState createState() => _TransactionContrainerState();
}

class _TransactionContrainerState extends State<TransactionContrainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: widget.onPressShare,
                    child: CircleAvatar(
                      backgroundColor: blueColor,
                      radius: 10,
                      child: const Icon(
                        Icons.share,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: widget.onPressDelete,
                    child: const Icon(
                      Icons.delete,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: 1,
                    color: blueColor.withOpacity(0.8),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                      fontFamily: title_font,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.destinataire,
                                  style: TextStyle(
                                      fontFamily: content_font,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.stringPrice,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    fontFamily: title_font,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              Text(widget.stringDate,
                                  style: TextStyle(
                                      fontFamily: content_font,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                      fontSize: 11)),
                              Text(
                                widget.stringSolde,
                                style: TextStyle(
                                    fontFamily: content_font,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600,
                                    fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 1,
                    color: blueColor.withOpacity(0.8),
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
