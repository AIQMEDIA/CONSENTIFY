import 'dart:io';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consentify/helper/widgets.dart';
import 'package:consentify/model/login_session_data.dart';
import 'package:consentify/model/past_agreement_data.dart';
import 'package:consentify/model/pdf_data.dart';
import 'package:consentify/model/qr_code_data.dart';
import 'package:consentify/model/qr_code_third.dart';
import 'package:consentify/model/registration_data.dart';
import 'package:consentify/model/user_data.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

import '../repository/main_repository.dart';

class MainController extends GetxController {
  final firebaseFirestore = FirebaseFirestore.instance;
  final MainRepository repository;
  var userFile = Rxn<File>();
  var qrCodeData = Rxn<QrCodeData>();
  var registrationData = Rxn<RegistrationData>();
  var qrUserData = Rxn<QrCodeThird>();
  var pdfData = Rxn<PdfData>();
  var userData = Rxn<UserData>();
  var signatureFile = Rxn<ui.Image>();
  final loginSession = Rxn<LoginSessionData>();

  final connector = Rxn<WalletConnect>();
  MainController(this.repository);

  Future<File> jsonDataStoreInFile(String data) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/my_file.txt');
    return file.writeAsString(data);
  }

  registrationMethod({Function callback}) {
    registrationData.value = RegistrationData();
    repository.getEthereumWalletApi(callback);
  }

  generateQrCode(Function callback) {
    qrCodeData.value = QrCodeData();

    repository.generateQrCodeStep1(callback: callback);
  }

  setPdfData(File file, Function callback) {
    pdfData.value = PdfData();

    repository.pdfIpFs(file, callback);
  }

  storeDataInFirebase(
      {@required String publicKey,
      @required String value,
      @required Function callback}) {
    final pastAgreementData =
        PastAgreementData(publicKey: publicKey, value: value);

    firebaseFirestore
        .collection("Key")
        .doc()
        .set(pastAgreementData.toMap())
        .then((value) {
      callback();
    }).catchError((e) {
      showSnackWithoutContext("error $e");
    });
  }

  
}
