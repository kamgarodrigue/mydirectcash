import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key, required this.getCode}) : super(key: key);
  final void Function(String) getCode;
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //  if (result != null)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text('  Data: ',
                          maxLines: 3, overflow: TextOverflow.ellipsis),
                    ),

                    const Text('Scan a code'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              widget.getCode("");
                              Navigator.of(context).pop();
                            },
                            child: const Text('Fermer',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        /*  Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (result != null) {
                                widget.getCode(result!.code!);

                                Navigator.of(context).pop();
                              } else {
                                widget.getCode("");
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('valider',
                                style: TextStyle(fontSize: 20)),
                          ),
                        )*/
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Container();
  }

  /*controller
      ..scannedDataStream.listen(
        (scanData) {
          if (scanData.code != "") {
            setState(() {
              result = scanData;
            });
            Future.delayed(
              Duration(seconds: 1),
              () {
                widget.getCode(result!.code!);
                Navigator.of(context).pop();
              },
            );
          }
        },
      );*/
}
