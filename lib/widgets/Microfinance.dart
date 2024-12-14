import 'package:flutter/material.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';

class Microfinance extends StatelessWidget {
  final String image,name,slogant;void Function()? ontap;
   Microfinance({super.key,required this.image,required this.name,required this.slogant,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: ontap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 00),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    
                    child: Image.asset(
                      fit:BoxFit.cover ,
                      image,
                      width:60,
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           name,
                            style: TextStyle(
                                fontFamily: title_font,
                                color: blueColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text( slogant,
                            style: TextStyle(
                                fontFamily: content_font,
                                fontSize: 11.5,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}