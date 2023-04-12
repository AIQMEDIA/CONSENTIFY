import 'dart:io';

import 'package:consentify/db/database.dart';
import 'package:consentify/get/controller/past_agreement_controller.dart';
import 'package:consentify/helper/widgets.dart';
import 'package:consentify/model/agreement.dart';
import 'package:consentify/model/past_agreement_data.dart';
import 'package:consentify/screens/pdf_viewer.dart';
import 'package:consentify/widgets/agreement_card_widget.dart';
import 'package:consentify/widgets/agreement_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PastAgreement extends StatefulWidget {
  static String id = 'past_agreement_screen';
  @override
  _PastAgreementState createState() => _PastAgreementState();
}

class _PastAgreementState extends State<PastAgreement> {
  List<Agreement> agreements;

  final controller = Get.find<PastAgreementController>();

  final isLoadingPdf = false.obs;

  @override
  void initState() {
    super.initState();

    controller.getDataInFirebase();
  }

  Future refreshAgreements() async {
    this.agreements = await AgreementDatabase.instance.readAllAgreement();
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Past Agreements')),
      body: Obx((() {
        return controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 5,
                ),
              )
            : Center(
                child: controller.pastAgreements.isEmpty
                    ? Text(
                        'No Past Agreements',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      )
                    : newBuildAgreements(
                        pastAgreementData: controller.pastAgreements),
              );
      })),
    );
  }

  Widget newBuildAgreements(
      {@required List<PastAgreementData> pastAgreementData}) {
    return ListView.builder(
        itemCount: pastAgreementData.length,
        itemBuilder: (context, index) {
          final agreement = pastAgreementData[index];

          return Obx(() => Material(
                elevation: 8,
                shadowColor: Colors.grey.shade700,
                child: ListTile(
                  leading: agreement.isLoading.value
                      ? CupertinoActivityIndicator(
                          color: Colors.red.shade400,
                        )
                      : Icon(
                          Icons.picture_as_pdf,
                          color: Colors.red.shade400,
                        ),
                  onTap: () async {
                    agreement.isLoading.value = true;
                    dynamic file =
                        await controller.decodeData(id: agreement.value);

                    agreement.isLoading.value = false;

                    if (file is File) {
                      Get.to(PdfViewer(
                        file,
                        isPast: true,
                      ));
                    }

                    if (file is String) {
                      showSnackWithoutContext(file);
                    }
                  },
                  title: agreement.value.toString().text.size(Vx.dp14).make(),
                ),
              ).pSymmetric(h: 20, v: 8));
        });
  }

  Widget buildAgreements(
          {@required List<PastAgreementData> pastAgreementData}) =>
      StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: pastAgreementData.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final agreement = pastAgreementData[index];

          return Obx(() => agreement.isLoading.value
              ? CupertinoActivityIndicator()
              : Material(
                  shadowColor: Colors.red,
                  elevation: 8,
                  child: ListTile(
                    onTap: () async {
                      agreement.isLoading.value = true;
                      dynamic file =
                          await controller.decodeData(id: agreement.value);

                      agreement.isLoading.value = false;

                      if (file is File) {
                        Get.to(PdfViewer(file));
                      }

                      if (file is String) {
                        showSnackWithoutContext(file);
                      }
                    },
                    title: agreement.value.toString().text.size(Vx.dp14).make(),
                  ),
                ).pSymmetric(h: 4, v: 8));
        },
      );
}
