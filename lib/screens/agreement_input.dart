import 'dart:ui' as ui;
import 'package:consentify/db/database.dart';
import 'package:consentify/model/agreement.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:consentify/constants.dart';
import 'package:flutter/material.dart';
import 'package:consentify/api/pdf_api.dart';
import 'package:open_file/open_file.dart';
import 'package:consentify/notification_plugin.dart';

class AgreementInput extends StatefulWidget {
  static String id = 'agreement_input_screen';

  @override
  _AgreementInputState createState() => _AgreementInputState();
}

class _AgreementInputState extends State<AgreementInput> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  String consentAsker;
  String consentGiver;
  String consentAskerEmail;
  String consentGiverEmail;

  @override
  void initState() {
    super.initState();
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState.clear();
  }

  Future onSubmit() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));

    final image = await signatureGlobalKey.currentState.toImage();
    final imageSignature =
        await image.toByteData(format: ui.ImageByteFormat.png);

    final file = await PdfApi.generatePDF(
        consentAsker: consentAsker,
        consentGiver: consentGiver,
        imageSignature: imageSignature);

    Navigator.of(context).pop();
    await OpenFile.open(file.path);
    if (consentAsker != null && consentGiver != null) {
      await notificationPlugin.scheduleNotification();
    }
    addAgreement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consent Agreement')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Enter name of person asking consent',
                    style: kQuestionStyle),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        consentAsker = value;
                      },
                      decoration: kTextFieldDecoration),
                ),
                SizedBox(height: 30),
                Text('Enter name of person giving consent',
                    style: kQuestionStyle),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        consentGiver = value;
                      },
                      decoration: kTextFieldDecoration),
                ),
                SizedBox(height: 30),
                Text('Enter email ID of person asking consent',
                    style: kQuestionStyle),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        consentAskerEmail = value;
                      },
                      decoration: kTextFieldDecoration),
                ),
                SizedBox(height: 30),
                Text('Enter email ID of person giving consent',
                    style: kQuestionStyle),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        consentGiverEmail = value;
                      },
                      decoration: kTextFieldDecoration),
                ),
                SizedBox(height: 30),
                Container(
                  width: 100,
                  height: 150,
                  child: SfSignaturePad(
                    key: signatureGlobalKey,
                    backgroundColor: Colors.white,
                    strokeColor: Colors.black,
                    minimumStrokeWidth: 1.0,
                    maximumStrokeWidth: 4.0,
                  ),
                ),
                Row(
                  children: <Widget>[
                    TextButton(
                      child: Text('Confirm', style: kQuestionStyle),
                      onPressed: onSubmit,
                    ),
                    TextButton(
                      child: Text('Clear', style: kQuestionStyle),
                      onPressed: _handleClearButtonPressed,
                    )
                  ],
                ),
                Center(
                  child: MaterialButton(
                      child: Text("Back"),
                      color: kPrimaryColor,
                      onPressed: () async {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // onNotificationInLowerVersions(ReceivedNotification receivedNotification) {}

  Future addAgreement() async {
    final agreement = Agreement(
      consentAsker: consentAsker,
      consentGiver: consentGiver,
      consentAskerEmail: consentAskerEmail,
      consentGiverEmail: consentGiverEmail,
      agreementTime: DateTime.now(),
    );

    await AgreementDatabase.instance.create(agreement);
  }
}
