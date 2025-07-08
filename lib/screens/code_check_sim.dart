import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mydirectcash/screens/register.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:page_transition/page_transition.dart';


class CodeCheckSim extends StatefulWidget {
  const CodeCheckSim({super.key});

  @override
  _CodeCheckSimState createState() => _CodeCheckSimState();
}

class _CodeCheckSimState extends State<CodeCheckSim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover)),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              color: blueColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: const Text(
                    'Temps écoulé, votre SIM est dans le téléphone ? Si oui vérifiez votre connexion. Essayez à nouveau.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: content_font,
                      color: Colors.white,
                    ),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: OtpTextField(
                      keyboardType: TextInputType.number,
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: content_font,
                          color: Colors.white),
                      numberOfFields: 6,
                      fieldWidth: 20,
                      borderColor: Colors.white,
                      fillColor: Colors.white,

                      focusedBorderColor: Colors.blue.shade200,
                      showFieldAsBox: false,

                      onCodeChanged: (String code) {},
                      /* onSubmit: (String verificationCode) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Verification Code"),
                                content:
                                    Text('Code entered is $verificationCode'),
                              );
                            });
                      },*/ // end onSubmit
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              backgroundColor:  blueColor,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 50)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: Register()));
                              },
                              child: const Text(
                                'SUIVANT',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: () {},
                        child: Text("Renvoyer le code ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: content_font,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: blueColor))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
