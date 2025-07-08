import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/utils/colors.dart';

class DialogWidget {
  static Future<void> loadingDialog(context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            Center(child: CircularProgressIndicator(color: blueColor)));
  }

  static Future<void> success(
    context, {
    required String title,
    required String? content,
    required Color color,
    required Function() callback,
  }) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            buttonPadding: const EdgeInsets.all(30.0),
            icon: SvgPicture.asset(
              "assets/svg/Texture.svg",
              height: 100,
              colorFilter: ColorFilter.mode(blueColor, BlendMode.srcIn),
            ),
            title: Text(title),
            titleTextStyle: TextStyle(
              color: color,
              fontSize: 20.0,
            ),
            content: content == null
                ? null
                : Text(
                    content,
                    textAlign: TextAlign.center,
                  ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      padding: const EdgeInsets.symmetric(horizontal: 50)),
                  onPressed: () => callback(),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          );
        });
  }

  static Future<void> warning(
    context, {
    required String title,
    required String? content,
    required Color color,
    required Function() callback,
  }) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            buttonPadding: const EdgeInsets.all(30.0),
            icon: SvgPicture.asset(
              "assets/svg/Texture.svg",
              height: 100,
              colorFilter: ColorFilter.mode(blueColor, BlendMode.srcIn),
            ),
            title: Text(title),
            titleTextStyle: TextStyle(
              color: color,
              fontSize: 20.0,
            ),
            content: content == null
                ? null
                : Text(
                    content,
                    textAlign: TextAlign.center,
                  ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      padding: const EdgeInsets.symmetric(horizontal: 50)),
                  onPressed: () => callback(),
                  child: Text(
                    '${AppLocalizations.of(context)!.translate('Valider')}',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          );
        });
  }

  static Future<void> error(
    context, {
    required String title,
    required String? content,
    required Color color,
    required Function() callback,
  }) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            buttonPadding: const EdgeInsets.all(30.0),
            icon: SvgPicture.asset(
              "assets/svg/Texture.svg",
              height: 100,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            title: Text(title),
            titleTextStyle: TextStyle(
              color: color,
              fontSize: 20.0,
            ),
            content: content == null
                ? null
                : Text(
                    content,
                    textAlign: TextAlign.center,
                  ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      padding: const EdgeInsets.symmetric(horizontal: 50)),
                  onPressed: () => callback(),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          );
        });
  }

  static Future<void> complexDialog(context,
      {required String title,
      required String? content,
      required Color color,
      required Function() callback}) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            buttonPadding: const EdgeInsets.all(30.0),
            actionsOverflowButtonSpacing: 10,
            icon: SvgPicture.asset(
              "assets/svg/Texture.svg",
              height: 100,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            title: Text(title),
            titleTextStyle: TextStyle(color: color, fontSize: 20.0),
            content: content == null
                ? null
                : Text(
                    content,
                    textAlign: TextAlign.center,
                  ),
            actions: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        padding: const EdgeInsets.symmetric(horizontal: 40)),
                    onPressed: () => callback(),
                    child: Text(
                      '${AppLocalizations.of(context)!.translate('Valider')}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: blueColor),
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      '${AppLocalizations.of(context)!.translate('annuler')}',
                      style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
              ],
             ),
            ],
          );
        });
  }
}
