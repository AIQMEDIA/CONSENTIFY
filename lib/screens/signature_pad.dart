import 'dart:developer';

import 'package:consentify/get/controller/main_controller.dart';
import 'package:consentify/screens/pdf_viewer.dart';
import 'package:consentify/screens/qrview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:ui' as ui;

import '../constants.dart';

class SignaturePadPage extends StatefulWidget {
  @override
  State<SignaturePadPage> createState() => _SignaturePadPageState();
}

class _SignaturePadPageState extends State<SignaturePadPage> {
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  final controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            (context.percentHeight * 5).heightBox,
            Container(
              alignment: Alignment.center,
              child: SfSignaturePad(
                key: _signaturePadKey,
                strokeColor: Vx.black,
                backgroundColor: Colors.grey[200],
              ),
              height: 150,
              width: context.percentWidth * 80,
            ).centered(),
            CupertinoButton(
                color: kPrimaryColor,
                child: Text("Save Signature"),
                onPressed: () async {
                  ui.Image image =
                      await _signaturePadKey.currentState.toImage();
                  controller.signatureFile.value = image;
                  Navigator.pushNamed(context, QrScanPage.id);
                  // Get.back();
                }).p12(),
          ],
        ),
      ),
    );
  }
}
