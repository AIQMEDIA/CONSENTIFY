import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consentify/get/controller/main_controller.dart';
import 'package:consentify/get/repository/past_agreement_repository.dart';
import 'package:consentify/helper/widgets.dart';
import 'package:consentify/model/past_agreement_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PastAgreementController extends GetxController {
  final firebaseFirestore = FirebaseFirestore.instance;

  final pastAgreements = List<PastAgreementData>.empty(growable: true).obs;
  final PastAgreementRepository repository;
  PastAgreementController(this.repository);

  getDataInFirebase() {
    final publicKey =
        Get.find<MainController>().registrationData.value.publicKey;
    firebaseFirestore
        .collection("Key")
        .where('publicKey', whereIn: [publicKey])
        .get()
        .then((value) {
          if (value.docs.isEmpty) {
            showSnackWithoutContext("No Past Agreement Found!");
            return;
          }

          for (var item in value.docs) {
            final data = PastAgreementData.fromMap(item.data());

            pastAgreements.add(data);
          }
        }, onError: (e) {
          showSnackWithoutContext("Failed to Get Data!");
        });
  }

  decodeData({@required String id}) {
    repository.getIpfsValue(id: id);
  }
}
