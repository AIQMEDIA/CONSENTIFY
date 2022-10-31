import 'package:consentify/api/api_services/bLoc.dart';
import 'package:consentify/screens/qrcode.dart';
import 'package:consentify/screens/qrview.dart';
import 'package:flutter/material.dart';

class AgreementInput extends StatefulWidget {
  static String id = 'agreement_input_screen';
  // const AgreementInput({Key key}) : super(key: key);

  @override
  State<AgreementInput> createState() => _AgreementInputState();
}

class _AgreementInputState extends State<AgreementInput> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Consent Agreement',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 76,
          ),
          IconButton(
            icon: Icon(Icons.qr_code_scanner_rounded),
            onPressed: (() {
              Navigator.pushNamed(context, QrScanPage.id);
            }),
          ),
        ],
      )),
      // body:
      body: Qrcode(),

      //  StreamBuilder<GetEthereumwalletModel>(
      //     stream: getEthereumwalletbloc.getEthereumwalletstream,
      //     builder: (context,
      //         AsyncSnapshot<GetEthereumwalletModel>
      //             getethereumwalletsnapshot) {
      //       if (!getethereumwalletsnapshot.hasData) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       return
      //       Container(
      //           child: Text(
      //         getethereumwalletsnapshot.data.xpub.toString(),
      //       ));
      //     }

      //     )
    );
  }
}

// class AgreementInput extends StatefulWidget {
// static String id = 'agreement_input_screen';

//   @override
//   _AgreementInputState createState() => _AgreementInputState();
// }

// class _AgreementInputState extends State<AgreementInput> {
// final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
// String consentAsker;
// String consentGiver;
// String consentAskerEmail;
// String consentGiverEmail;

// // === form key====
// final _formvalidatekey = GlobalKey<FormState>();

// @override
// void initState() {
//   super.initState();
// }

// void _handleClearButtonPressed() {
//   signatureGlobalKey.currentState.clear();
//   ClearText();
// }

// Future onSubmit() async {
//   if (_formvalidatekey.currentState.validate()) {
//     showSucssesfulToast();
//     signatureGlobalKey.currentState.clear();
//     ClearText();

//     // showDialog(
//     //     barrierDismissible: false,
//     //     context: context,
//     //     builder: (context) => Center(child: CircularProgressIndicator()));

//     final image = await signatureGlobalKey.currentState.toImage();
//     final imageSignature =
//         await image.toByteData(format: ui.ImageByteFormat.png);

//     final file = await PdfApi.generatePDF(
//         consentAsker: consentAsker,
//         consentGiver: consentGiver,
//         imageSignature: imageSignature);

//     Navigator.of(context).pop();
//     await OpenFile.open(file.path);
//     if (consentAsker != null && consentGiver != null) {
//       await notificationPlugin.scheduleNotification();
//     }
//     addAgreement();
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//         title: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text('Consent Agreement'),
//         IconButton(
//           icon: Icon(Icons.qr_code),
//           onPressed: (() {
//             Navigator.pushNamed(context, Qrcode.id);
//           }),
//         ),
//         IconButton(
//           icon: Icon(Icons.qr_code_scanner_rounded),
//           onPressed: (() {
//             Navigator.pushNamed(context, QrScanPage.id);
//           }),
//         ),
//       ],
//     )),
//     body: SafeArea(
//       // child: Padding(
//       // padding: EdgeInsets.only(top: 20, left: 20, right: 20),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 18, vertical: 30),
//         child: SingleChildScrollView(
//           // reverse: true,
//           child: Form(
//             key: _formvalidatekey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text('Enter name of person asking consent',
//                     style: kQuestionStyle),
//                 SizedBox(height: 20),
//                 Container(
//                   width: 300,
//                   child: TextFormField(
//                       cursorColor: Colors.white,
//                       style: TextStyle(color: Colors.white),
//                       controller: askingconsentController,
//                       validator: (String value) {
//                         if (value != null && value.isEmpty) {
//                           return " Name can't be empty";
//                         }
//                         return null;
//                       },
//                       onChanged: (value) {
//                         consentAsker = value;
//                       },
//                       decoration: kTextFieldDecoration),
//                 ),
//                 SizedBox(height: 30),
//                 Text('Enter name of person giving consent',
//                     style: kQuestionStyle),
//                 SizedBox(height: 20),
//                 Container(
//                   width: 300,
//                   child: TextFormField(
//                       cursorColor: Colors.white,
//                       style: TextStyle(color: Colors.white),
//                       controller: givingconsentController,
//                       validator: (String value) {
//                         if (value != null && value.isEmpty) {
//                           return " Name can't be empty";
//                         }
//                         return null;
//                       },
//                       onChanged: (value) {
//                         consentGiver = value;
//                       },
//                       decoration: kTextFieldDecoration),
//                 ),
//                 SizedBox(height: 30),
//                 Text('Enter email ID of person asking consent',
//                     style: kQuestionStyle),
//                 SizedBox(height: 20),
//                 Container(
//                   width: 300,
//                   child: TextFormField(
//                       cursorColor: Colors.white,
//                       style: TextStyle(color: Colors.white),
//                       controller: askingemailController,
//                       validator: (String value) {
//                         if (value != null && value.isEmpty) {
//                           return "E-mail can't be empty";
//                         } else if (!value.contains('@')) {
//                           return 'please Enter valid Email';
//                         } else if (!value.contains('.')) {
//                           return 'please Enter valid Email';
//                         }
//                         return null;
//                       },
//                       onChanged: (value) {
//                         consentAskerEmail = value;
//                       },
//                       decoration: kTextFieldDecoration),
//                 ),
//                 SizedBox(height: 30),
//                 Text('Enter email ID of person giving consent',
//                     style: kQuestionStyle),
//                 SizedBox(height: 20),
//                 Container(
//                   width: 300,
//                   child: TextFormField(
//                       cursorColor: Colors.white,
//                       style: TextStyle(color: Colors.white),
//                       controller: givinggemailController,
//                       validator: (String value) {
//                         if (value != null && value.isEmpty) {
//                           return "E-mail can't be empty";
//                         } else if (!value.contains('@')) {
//                           return 'please Enter valid Email';
//                         } else if (!value.contains('.')) {
//                           return 'please Enter valid Email';
//                         }
//                         return null;
//                       },
//                       onChanged: (value) {
//                         consentGiverEmail = value;
//                       },
//                       decoration: kTextFieldDecoration),
//                 ),
//                 SizedBox(height: 30),
//                 Container(
//                   width: 100,
//                   height: 150,
//                   child: SfSignaturePad(
//                     key: signatureGlobalKey,
//                     backgroundColor: Colors.white,
//                     strokeColor: Colors.black,
//                     minimumStrokeWidth: 1.0,
//                     maximumStrokeWidth: 4.0,
//                   ),
//                 ),
//                 Row(
//                   children: <Widget>[
//                     TextButton(
//                       child: Text('Confirm', style: kQuestionStyle),
//                       onPressed: onSubmit,
//                     ),
//                     TextButton(
//                       child: Text('Clear', style: kQuestionStyle),
//                       onPressed: _handleClearButtonPressed,
//                     )
//                   ],
//                 ),
//                 Center(
//                   child: MaterialButton(
//                       child: Text("Back"),
//                       color: kPrimaryColor,
//                       onPressed: () async {
//                         // showSucssesfulToast();
//                         showErrorToast();
//                         ClearText();
//                         Navigator.pop(context);
//                       }),
//                 )
//               ],
//             ),
//           ),
//           // padding: EdgeInsets.only(
//           //     bottom: MediaQuery.of(context).viewInsets.bottom),
//         ),
//       ),
//       // ),
//     ),
//   );
// }

// // onNotificationInLowerVersions(ReceivedNotification receivedNotification) {}

// Future addAgreement() async {
//   final agreement = Agreement(
//     consentAsker: consentAsker,
//     consentGiver: consentGiver,
//     consentAskerEmail: consentAskerEmail,
//     consentGiverEmail: consentGiverEmail,
//     agreementTime: DateTime.now(),
//   );

//   await AgreementDatabase.instance.create(agreement);
// }
// }
