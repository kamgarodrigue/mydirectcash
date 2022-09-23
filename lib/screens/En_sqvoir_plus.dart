import 'package:flutter/material.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/phone_number_entry.dart';
import 'package:mydirectcash/screens/register.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:mydirectcash/widgets/carousel_container.dart';
import 'package:page_transition/page_transition.dart';

class En_sqvoir_plus extends StatefulWidget {
  En_sqvoir_plus({Key? key}) : super(key: key);

  @override
  State<En_sqvoir_plus> createState() => _En_sqvoir_plusState();
}

class _En_sqvoir_plusState extends State<En_sqvoir_plus> {
  static List<Map> slides = [];
  late CarouselSliderController _carouselSliderController;

  GlobalKey<dynamic> _sliderKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _carouselSliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    slides = [
      {
        'image': 'assets/images/pexels-anna-nekrashevich-6802046.jpg',
        'title': "${AppLocalizations.of(context)!.translate('title1')}",
        'content': "${AppLocalizations.of(context)!.translate('content1')}"
      },
      {
        'image': 'assets/images/pexels-anna-nekrashevich-6801872.jpg',
        'title': "${AppLocalizations.of(context)!.translate('title2')}",
        'content': "${AppLocalizations.of(context)!.translate('content2')}"
      },
      {
        'image': 'assets/images/nubelson-fernandes-laLxjCYtkFY-unsplash.jpg',
        'title': "${AppLocalizations.of(context)!.translate('title3')}",
        'content': "${AppLocalizations.of(context)!.translate('content3')}"
      },
      {
        'image': 'assets/images/businessman-800x400.jpg',
        'title': "${AppLocalizations.of(context)!.translate('title4')}",
        'content': "${AppLocalizations.of(context)!.translate('content4')}"
      },
      {
        'image': 'assets/images/téléchargement.jpg',
        'title': "${AppLocalizations.of(context)!.translate('title5')}",
        'content': "${AppLocalizations.of(context)!.translate('content5')}"
      },
      {
        'image': 'assets/images/pexels-og-mpango-4090605.jpg',
        'title': "${AppLocalizations.of(context)!.translate('title6')}",
        'content': "${AppLocalizations.of(context)!.translate('content6')}"
      }
    ];
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _carouselSliderController.nextPage(Duration(milliseconds: 500));
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          hoverElevation: 0,
          child: Image.asset(
            'assets/images/ico-suivant.png',
            width: 50,
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
              child: CarouselSlider.builder(
                key: _sliderKey,
                unlimitedMode: true,
                controller: _carouselSliderController,
                slideBuilder: (index) {
                  final slide = slides[index];
                  return CarouselContainer(
                    image: slide['image'],
                    title: slide['title'],
                    content: slide['content'],
                  );
                },
                slideTransform: TabletTransform(),
                slideIndicator: CircularSlideIndicator(
                    padding: EdgeInsets.only(bottom: 40, left: 25),
                    alignment: Alignment.bottomLeft,
                    indicatorBorderColor: Colors.transparent,
                    indicatorBackgroundColor: Colors.grey.shade400,
                    indicatorRadius: 4,
                    currentIndicatorColor: blueColor,
                    indicatorBorderWidth: 0),
                itemCount: slides.length,
                initialPage: 0,
                enableAutoSlider: true,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back, size: 30))),
            )
          ],
        ));
  }
}
