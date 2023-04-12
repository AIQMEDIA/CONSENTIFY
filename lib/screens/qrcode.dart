import 'package:consentify/get/controller/main_controller.dart';
import 'package:consentify/helper/widgets.dart';
import 'package:consentify/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase/supabase.dart';

import '../constants.dart';
import '../model/qr_code_third.dart';

class Qrcode extends StatefulWidget {
  // const Qrcode({Key key}) : super(key: key);
  static String id = 'qrcode';

  @override
  State<Qrcode> createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  final controller = Get.find<MainController>();

  UserData qrCodeData;

  @override
  void initState() {
    controller.generateQrCode((UserData qrCodeThird) {
      this.qrCodeData = qrCodeThird;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              qrCodeData == null
                  ? Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    )
                  : QrImage(
                      data: qrCodeData.toJson(),
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
