import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:consentify/get/controller/main_controller.dart';
import 'package:consentify/helper/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants.dart';

class PdfViewer extends StatefulWidget {
  PdfViewer(this.file, {this.isPast=false});

  final File file;

 final bool isPast;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  final controller = Get.find<MainController>();

  bool isComplete = false;

  bool isLoad = false;
  // ByteData bytes;

  @override
  void initState() {
    // loadImage();

    super.initState();
  }

  // loadImage() async {
  //   var data = controller.signatureFile.value;
  //   bytes = await data.toByteData(format: ui.ImageByteFormat.png);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ZStack(
      [
        SfPdfViewer.file(widget.file),
        Positioned.fill(
            child: Align(
          alignment: Alignment.center,
          child: isComplete
              ? "Successfully Data uploaded!"
                  .text
                  .color(kPrimaryColor)
                  .center
                  .xl
                  .makeCentered()
              : Container(),
        )),
        Positioned.fill(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: widget.isPast
              ? Container()
              : isLoad
                  ? CircularProgressIndicator(
                      color: kPrimaryColor,
                    )
                  : CupertinoButton(
                      borderRadius: BorderRadius.circular(12),
                      color: kPrimaryColor,
                      child: "Submit".text.xl.black.make(),
                      onPressed: () {
                        controller.setPdfData(widget.file, (value) {
                          if (value.runtimeType == String) {
                            setState(() {
                              isComplete = false;
                              isLoad = false;
                            });
                          } else {
                            setState(() {
                              isComplete = true;
                              isLoad = false;
                            });
                          }
                        });

                        setState(() {
                          isLoad = true;
                        });
                      }),
        ))
      ],
    ));
  }
}
