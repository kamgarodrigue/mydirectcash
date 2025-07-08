import 'package:flutter/material.dart';
import 'package:mydirectcash/app_localizations.dart';
import 'package:mydirectcash/screens/Recharge_carte_credit_Amount.dart';
import 'package:mydirectcash/screens/recharge_directcash.dart';
import 'package:mydirectcash/screens/recharge_virement.dart';
import 'package:page_transition/page_transition.dart';

class ChoixDeRecharge extends StatelessWidget {
  const ChoixDeRecharge({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      // {
      //   'name': AppLocalizations.of(context)!.translate('Copmte OM/MOMO1'),
      //   'image': 'OM et MoMo.png',
      //   'callback': () => Navigator.push(
      //       context,
      //       PageTransition(
      //           type: PageTransitionType.rightToLeft, child: const OmMoMo())),
      // },
      {
        'name': AppLocalizations.of(context)!.translate('Transfert DirectCash'),
        'image': 'logo-alliance-transparent.png',
        'callback': () => Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: const RechargeDirectCash())),
      },
      {
        'name': AppLocalizations.of(context)!
            .translate('Carte de crédit/Paypal1')
            .toString(),
        'image': 'paypal-creditcard.png',
        'callback': () => Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const Recharge_carte_credit_Amount())),
      },
      {
        'name': AppLocalizations.of(context)!.translate('Virement Bancaire'),
        'image': 'Money-transfer.png',
        'callback': () => Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const RechargeVirement())),
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Choix de Recharge"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
            crossAxisSpacing: 16,
            mainAxisSpacing: 18,
            childAspectRatio: 0.9,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ChoixView(
              name: item['name'],
              image: item['image'],
              callback: item['callback'],
            );
          },
        ),
      ),
    );
  }
}

class ChoixView extends StatelessWidget {
  final String name;
  final String image;
  final Function callback;

  const ChoixView({
    super.key,
    required this.name,
    required this.image,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/$image"),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Define a list of items with their properties
