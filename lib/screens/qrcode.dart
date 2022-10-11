import 'package:consentify/constants.dart';
import 'package:consentify/utils/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qrcode extends StatefulWidget {
  // const Qrcode({Key key}) : super(key: key);
  static String id = 'qrcode';

  @override
  State<Qrcode> createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              QrImage(
                data: "HELLO CONSENTIFYYYY",
                //  givingconsentController.text,

                // givingconsentController.toString(),
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 40),
              // buildTextField(context),
            ],
          ),
        ),
      ),
    );
  }

//   Widget buildTextField(BuildContext) => TextField(
//         controller: givingconsentController,
//         decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(
//                 color: kPrimaryColor,
//               ),
//             ),
//             suffixIcon: IconButton(
//                 color: kPrimaryColor,
//                 icon: Icon(Icons.done, size: 30),
//                 onPressed: (() {
//                   setState(() {});
//                 }))),
//         cursorColor: Colors.white,
//       );
// }
}
