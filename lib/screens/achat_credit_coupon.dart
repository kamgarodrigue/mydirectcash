import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/Operateur.dart';
import 'package:mydirectcash/Repository/OperationServices.dart';
import 'package:mydirectcash/Repository/localisation.dart';
import 'package:mydirectcash/screens/achat_credit_coupon_password.dart';
import 'package:mydirectcash/screens/achat_credit_other.dart';
import 'package:mydirectcash/screens/achat_credit_password.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:mydirectcash/app_localizations.dart';

class Achat_credit_coupon extends StatefulWidget {
  final String regionCode;
  final String providerCode;
  var data;
  Achat_credit_coupon(
      {Key? key,
      required this.regionCode,
      required this.providerCode,
      required this.data})
      : super(key: key);

  @override
  State<Achat_credit_coupon> createState() => _Achat_credit_couponState();
}

class _Achat_credit_couponState extends State<Achat_credit_coupon> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<OperationServices>()
        .getOperatorsProduct(widget.regionCode, widget.providerCode);
    //context.read<Localisation>().initLocation();
  }

 

  final bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final operationServices = context.watch<OperationServices>();
    final locat = context.watch<Localisation>();
    print(locat);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover)),
                child: Wrap(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .07,
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: blueColor,
                              size: 30,
                            )),
                        Container(
                            width: 200,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: blueColor,
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  if (widget.regionCode == "CM") {
                                    var data = {
                                      "montant": "",
                                      "numero": "",
                                      "Id": "",
                                      "reseau": widget.data["reseau"],
                                      "device": "123456",
                                      "pass": "",
                                      "imei": "5258889"
                                    };
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: AchatCreditauther(
                                              data: data,
                                            )));
                                  }
                                },
                                child: Text(
                                  ' ${AppLocalizations.of(context)!.translate("montant")}',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )))
                      ],
                    ),
                  ),
                  SizedBox(
                    // padding: EdgeInsets.only(bottom: 200),
                    height: MediaQuery.of(context).size.height * .87,
                    child: GridView(
                      // scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.9),
                      shrinkWrap: true,
                      children: List.generate(
                          operationServices.produits.length,
                          (index) => InkWell(
                                onTap: () {
                                  widget.data["skucode"] =
                                      operationServices.produits[index].kuCode;
                                  widget.data["sendValue"] = operationServices
                                      .produits[index].maxSendValue;
                                  widget.data["displayName"] = operationServices
                                      .produits[index].displayName;
                                  print(operationServices.produits[index]
                                      .toJson());
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: AchatCreditPasswordCoupon(
                                            data: widget.data,
                                          )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          colors: [
                                            Color.fromRGBO(255, 255, 255, 1),
                                            Color.fromRGBO(3, 169, 244, 1),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                      image: DecorationImage(
                                          image: NetworkImage(operationServices
                                              .produits[index].urlImage!))),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          height: 70,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.black.withOpacity(0.5),
                                          child: Center(
                                            child: Text(
                                                operationServices
                                                    .produits[index]
                                                    .displayName!,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                    ),
                  ),
                ])),
            Container(
                child: _isLoading
                    ? Loader(loadingTxt: 'Content is loading...')
                    : Container())
          ],
        ));
  }
}
