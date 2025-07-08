import 'package:flutter/material.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';

class Microfinance extends StatelessWidget {
  final String image, name, slogant;
  void Function()? ontap;
  Microfinance(
      {super.key,
      required this.image,
      required this.name,
      required this.slogant,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            //   child: Image.asset(
            //     fit: BoxFit.cover,
            //     image,
            //     width: 75,
            //     height: 70,
            //   ),
            // ),
            Container(
              width: 75,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
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
                    // const SizedBox(
                    //   height: 2,
                    // ),
                    // Text(
                    //   slogant,
                    //   style: TextStyle(
                    //       fontFamily: content_font,
                    //       fontSize: 11.5,
                    //       color: Colors.grey.shade800,
                    //       fontWeight: FontWeight.w500),
                    // ),
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
