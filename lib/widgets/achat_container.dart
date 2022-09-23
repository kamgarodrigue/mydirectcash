import 'package:flutter/material.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';

class AchatContainer extends StatefulWidget {
  AchatContainer(
      {required this.numFacture,
      required this.title,
      required this.stringDate,
      required this.stringPrice,
      required this.stringSolde,
      required this.onPressShare,
      required this.onPressDelete});
  String title, numFacture, stringDate, stringPrice, stringSolde;
  void Function() onPressShare;
  void Function() onPressDelete;

  @override
  _AchatContainerState createState() => _AchatContainerState();
}

class _AchatContainerState extends State<AchatContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
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
                      backgroundColor: greenColor,
                      radius: 10,
                      child: Icon(
                        Icons.share,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: widget.onPressDelete,
                    child: Icon(
                      Icons.delete,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: 1,
                    color: blueColor.withOpacity(0.8),
                  ),
                  SizedBox(
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
                                  '${widget.title}',
                                  style: TextStyle(
                                      fontFamily: title_font,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '${widget.numFacture}',
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
                                '${widget.stringPrice}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontFamily: title_font,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              Text('${widget.stringDate}',
                                  style: TextStyle(
                                      fontFamily: content_font,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                      fontSize: 11)),
                              Text(
                                '${widget.stringSolde}',
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
                  SizedBox(
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
