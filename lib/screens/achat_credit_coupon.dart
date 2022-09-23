import 'package:flutter/material.dart';
import 'package:mydirectcash/Models/Operateur.dart';
import 'package:mydirectcash/Repository/OperationServices.dart';
import 'package:mydirectcash/screens/settings.dart';
import 'package:mydirectcash/utils/colors.dart';
import 'package:mydirectcash/widgets/Loader.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Achat_credit_coupon extends StatefulWidget {
  final String regionCode;
  final String providerCode;
  Achat_credit_coupon(
      {Key? key, required this.regionCode, required this.providerCode})
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
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final operationServices = context.watch<OperationServices>();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: blueColor,
              )),
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
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: blueColor,
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
                  GridView(
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
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
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
                                                  .produits[index].displayName!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
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
