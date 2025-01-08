import 'package:flutter/material.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';

class CarouselContainer extends StatefulWidget {
  CarouselContainer(
      {super.key, required this.image, required this.title, required this.content});
  String image, title, content;
  @override
  _CarouselContainerState createState() => _CarouselContainerState();
}

class _CarouselContainerState extends State<CarouselContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.image), fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 40,
                  child: Image.asset(
                    'assets/images/logo-alliance-transparent.png',
                    width: 50,
                  ),
                )
              ],
            ),
          ),
          Container(
            //height: MediaQuery.of(context).size.height / 2.2,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontFamily: title_font,
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  widget.content,
                  style: const TextStyle(
                      fontFamily: content_font,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
