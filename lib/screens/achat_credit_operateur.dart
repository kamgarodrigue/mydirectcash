import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mydirectcash/Models/Operateur.dart';
import 'package:mydirectcash/Repository/OperationServices.dart';
import 'package:mydirectcash/screens/achat_credit_coupon.dart';
import 'package:mydirectcash/screens/achat_credit_other.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Achat_credit_operateur extends StatefulWidget {
  final String regionCode;
  var data;
  Achat_credit_operateur(
      {Key? key, required this.regionCode, required this.data})
      : super(key: key);

  @override
  State<Achat_credit_operateur> createState() => _Achat_credit_operateurState();
}

class _Achat_credit_operateurState extends State<Achat_credit_operateur> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<OperationServices>()
        .getContryOperator(widget.regionCode, false);
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover)),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.arrow_back,
                              color: blueColor,
                              size: 30,
                            )),
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
                                            child: Settings()));
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
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.8),
                      itemCount: operationServices.operateurs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (operationServices
                                    .operateurs[index].providerCode ==
                                "") {
                              var data = {
                                "montant": "",
                                "numero": "",
                                "Id": "",
                                "reseau": operationServices
                                    .operateurs[index].providerName,
                                "device": "123456",
                                "pass": "",
                                "imei": "5258889",
                                "image": operationServices
                                    .operateurs[index].urlImage!
                              };

                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: AchatCreditauther(
                                        data: data,
                                      )));
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              widget.data["reseau"] = operationServices
                                  .operateurs[index].providerName!
                                  .split(" ")[0];
                              widget.data["image"] =
                                  operationServices.operateurs[index].urlImage;
                              print(widget.data);

                              context
                                  .read<OperationServices>()
                                  .getOperatorsProduct(
                                      widget.regionCode,
                                      operationServices
                                          .operateurs[index].providerCode)
                                  .then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: Achat_credit_coupon(
                                          data: widget.data,
                                          regionCode: widget.regionCode,
                                          providerCode: operationServices
                                              .operateurs[index].providerCode!,
                                        )));
                                print(value);
                              }).catchError((error) {
                                setState(() {
                                  _isLoading = false;
                                });

                                print(error);
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: blueColor.withOpacity(0.9),
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(255, 255, 255, 1),
                                      Color.fromRGBO(3, 169, 244, 1),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                image: operationServices
                                            .operateurs[index].providerCode !=
                                        ""
                                    ? DecorationImage(
                                        image: NetworkImage(operationServices
                                            .operateurs[index].urlImage!))
                                    : DecorationImage(
                                        image: AssetImage(operationServices
                                            .operateurs[index].urlImage!))),
                          ),
                        );
                      },
                    ),
                  ))
                ])),
            Container(
                child: _isLoading
                    ? Loader(loadingTxt: 'Content is loading...')
                    : Container())
          ],
        ));
  }
}
