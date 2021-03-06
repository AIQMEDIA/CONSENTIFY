import 'package:consentify/db/database.dart';
import 'package:consentify/model/agreement.dart';
import 'package:consentify/widgets/agreement_card_widget.dart';
import 'package:consentify/widgets/agreement_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PastAgreement extends StatefulWidget {
  static String id = 'past_agreement_screen';
  @override
  _PastAgreementState createState() => _PastAgreementState();
}

class _PastAgreementState extends State<PastAgreement> {
  List<Agreement> agreements;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshAgreements();
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
      body: Center(
        child: agreements.isEmpty
            ? Text(
                'No Past Agreements',
                style: TextStyle(color: Colors.white, fontSize: 24),
              )
            : buildAgreements(),
      ),
    );
  }

  Widget buildAgreements() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: agreements.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final agreement = agreements[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AgreementDetailPage(agreementId: agreement.id),
              ));

              refreshAgreements();
            },
            child: AgreementCardWidget(agreement: agreement, index: index),
          );
        },
      );
}
