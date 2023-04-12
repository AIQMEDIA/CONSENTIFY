import 'dart:developer';
import 'dart:io';

import 'package:consentify/constants.dart';
import 'package:consentify/get/controller/main_controller.dart';
import 'package:consentify/helper/widgets.dart';
import 'package:consentify/screens/pdf_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../api/pdf_api.dart';
import '../api/pdf_api.dart';
import '../model/user_data.dart';
import 'dart:ui' as ui;

class QrScanPage extends StatefulWidget {
  // const QrScanPage({Key key}) : super(key: key);
  static String id = 'QRscanner';

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  final mainController = Get.find<MainController>();
  Barcode barcode;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildQrView(context),
              Positioned(bottom: 10, child: buildResult()),
              Positioned(
                top: 10,
                child: buildControlButtons(),
              )
            ],
          ),
        ),
      );
  Widget buildControlButtons() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: FutureBuilder<bool>(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(
                          snapshot.data ? Icons.flash_on : Icons.flash_off);
                    } else {
                      return Container();
                    }
                  }),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
            ),
            IconButton(
              icon: FutureBuilder(
                  future: controller?.getCameraInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(Icons.switch_camera);
                    } else {
                      return Container();
                    }
                  }),
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
            ),
          ],
        ),
      );

  Widget buildResult() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white24),
        child: Text(
          barcode != null ? 'Result:${barcode.code}' : 'Scan a code!',
        ),
      );

  Widget buildQrView(BuildContext context) => QRView(
        key: qrkey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: kPrimaryColor,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((barcode) async {
      setState(() => this.barcode = barcode);

      if (mainController.signatureFile.value == null) {
        showSnackWithoutContext("Please Signature select!");
        return;
      }

      var data = UserData.fromJson(barcode.code);
      var name = mainController.userData.value.username;
      var _sign = mainController.signatureFile.value;
      var sign = await _sign.toByteData(format: ui.ImageByteFormat.png);
      var pdf = await PdfApi.generatePDF(
          consentAsker: data.username,
          consentGiver: name,
          imageSignature: sign);

      Get.off(PdfViewer(pdf));
      //now call api
    });
  }
}
