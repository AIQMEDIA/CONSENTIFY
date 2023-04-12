import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PdfApi {
  static Future<File> generatePDF({
    @required String consentAsker,
    @required String consentGiver,
    @required ByteData imageSignature,
  }) async {
    final document = PdfDocument();
    final page = document.pages.add();

    drawSignature(consentAsker, consentGiver, page, imageSignature);

    return saveFile(document);
  }

  static void drawSignature(String consentAsker, String consentGiver,
      PdfPage page, ByteData imageSignature) {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    final date = formatter.format(now);
    String paragraphText =
        'My name is $consentGiver and I hereby consent to engaging in sexual activity with $consentAsker on $date. I hereby confirm that we both are atleast 18 years old. Neither of us are intoxicated or in duress. We will not share this agreement with anyone but ourselves, law enforcement or a lawyer.';
    final pageSize = page.getClientSize();
    final PdfBitmap image = PdfBitmap(imageSignature.buffer.asUint8List());
    page.graphics.drawString(
        'CONSENT AGREEMENT', PdfStandardFont(PdfFontFamily.timesRoman, 35),
        brush: PdfBrushes.orange,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.top));
    final PdfLayoutResult layoutResult = PdfTextElement(
            text: paragraphText,
            font: PdfStandardFont(PdfFontFamily.helvetica, 20),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(0, 50, pageSize.width, pageSize.height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate));
    page.graphics.drawLine(
        PdfPen(PdfColor(255, 0, 0)),
        Offset(0, layoutResult.bounds.bottom + 10),
        Offset(page.getClientSize().width, layoutResult.bounds.bottom + 10));
// Draw the next paragraph/content.

    page.graphics.drawImage(
      image,
      Rect.fromLTWH(pageSize.width / 2, pageSize.height - 100, 200, 100),
    );
  }

  static Future<File> saveFile(PdfDocument document) async {
    final path = await getApplicationDocumentsDirectory();
    final fileName =
        path.path + '/ConsentAgreement${DateTime.now().toIso8601String()}.pdf';
    final file = File(fileName);

    log("Sunil file path ${fileName}");

    file.writeAsBytes(document.save());
    document.dispose();
    return file;
  }
}
