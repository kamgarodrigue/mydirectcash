import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mydirectcash/Repository/OperationServices.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Recharge_carte_credit_Token.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/utils/fonts.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Grille_Tarifaire_model extends StatefulWidget {
  String title, model;
  Grille_Tarifaire_model({Key? key, required this.model, required this.title})
      : super(key: key);

  @override
  State<Grille_Tarifaire_model> createState() => _Grille_Tarifaire_modelState();
}

class _Grille_Tarifaire_modelState extends State<Grille_Tarifaire_model> {
  final bool _isLoading = false;
  bool _isOscure = true;
  String montant = "";

  void togle() {
    setState(() {
      _isOscure = !_isOscure;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<OperationServices>()
        .getTarifs(widget.model)
        .then((value) => print(""));
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> column = [
      {
        "title": "${AppLocalizations.of(context)!.translate("Amount")}",
        "image": "assets/images/mtn_momo.png",
      },
      {
        "title": "${AppLocalizations.of(context)!.translate("Frais")}",
        "image": "assets/images/background.png",
      },
      /* {
        "title":
            "${AppLocalizations.of(context)!.translate('Payement Marchand')}",
        "image": "assets/images/om.png",
      },*/
    ];

    List<String> range = ["100 à 5 000", "5 551 à 6 500", "6 501 à 10 000"];
    List<String> TarifOm = ["3%", "165 - 195", "180"];
    List<String> TarifMomO = ['3%', "170", "170"];
    final operationServices = context.watch<OperationServices>();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 40,
                          height: 50,
                          color: Colors.transparent,
                          child: Stack(children: [
                            Positioned(
                                top: 12,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: const Settings()));
                                  },
                                  child: Image.asset(
                                    'assets/images/ico-parametre.png',
                                    width: 40,
                                  ),
                                ))
                          ]),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: blueColor,
                          ),
                        ),
                        const SizedBox(width: 50),
                        Text(widget.title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: title_font,
                                color: blueColor,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  DataTable(
                    columns: List.generate(
                        column.length,
                        (index) => DataColumn(
                              label: Text(column[index]["title"],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: title_font,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900)),
                            )),
                    rows: List<DataRow>.generate(operationServices.tarif.length,
                        (index) {
                      List<dynamic> tarifs = operationServices.tarif;
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(
                            '${tarifs[index]["fromAmount"]} - ${tarifs[index]["toAmount"]} ',
                            //textAlign: TextAlign.center,
                          )),
                          DataCell(Container(
                            child: Text(
                              tarifs[index]["fee"],
                              textAlign: TextAlign.center,
                            ),
                          )),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
            Container(
                child: _isLoading
                    ? const Loader(loadingTxt: 'Content is loading...')
                    : Container())
          ],
        ));
  }
}
