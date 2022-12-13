import 'package:consentify/db/database.dart';
import 'package:consentify/get/controller/past_agreement_controller.dart';
import 'package:consentify/model/agreement.dart';
import 'package:consentify/model/past_agreement_data.dart';
import 'package:consentify/widgets/agreement_card_widget.dart';
import 'package:consentify/widgets/agreement_detail_page.dart';
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

  bool isLoading = false;

  final controller = Get.find<PastAgreementController>();

  @override
  void initState() {
    super.initState();

    // refreshAgreements();

    controller.getDataInFirebase();
  }

  // @override
  // void dispose() {
  //   AgreementDatabase.instance.close();
  //   super.dispose();
  // }

  Future refreshAgreements() async {
    this.agreements = await AgreementDatabase.instance.readAllAgreement();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Past Agreements')),
      body: Obx((() {
        return Center(
          child: controller.pastAgreements.isEmpty
              ? Text(
                  'No Past Agreements',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                )
              : buildAgreements(
                  pastAgreementData: controller.pastAgreements.value),
        );
      })),
    );
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

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AgreementDetailPage(agreementId: agreement.value),
              ));

              // refreshAgreements();
            },
            // child: AgreementCardWidget(agreement: agreement, index: index),
            child: Card(
              child: ListTile(
                onTap: () {
                  controller.decodeData(id: agreement.value);
                },
                title: agreement.value.toString().text.size(Vx.dp14).make(),
              ),
            ).pSymmetric(h: 4, v: 8),
          );
        },
      );
}
