import 'package:consentify/get/binding/past_agrement_binding.dart';
import 'package:consentify/get/controller/main_controller.dart';
import 'package:consentify/screens/agreement_input.dart';
import 'package:consentify/screens/past_agreement.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:consentify/constants.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/toastmessage.dart';

class NewAgreement extends StatelessWidget {
  final controller = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VStack(
              [
                GestureDetector(
                  onTap: () {
                    var data = controller.registrationData.value.publicKey;
                    if (data.isEmptyOrNull) {
                      data = controller.loginSession.value.account;
                    }
                    copyClipboard(data);
                  },
                  child: Row(
                    children: [
                      "Public Key :"
                          .text
                          .bold
                          .color(kPrimaryColor)
                          .size(Vx.dp16)
                          .make(),
                      5.widthBox,
                      controller.registrationData.value == null
                          ? "${controller.loginSession.value.account}"
                              .text
                              .color(kPrimaryColor)
                              .size(Vx.dp16)
                              .make()
                              .box
                              .width(context.percentWidth * 60)
                              .make()
                          : "${controller.registrationData.value.publicKey}"
                              .text
                              .color(kPrimaryColor)
                              .size(Vx.dp16)
                              .make()
                              .box
                              .width(context.percentWidth * 60)
                              .make()
                    ],
                  ).centered(),
                ),
                5.heightBox,
                controller.registrationData.value == null
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          var data =
                              controller.registrationData.value.privateKey;
                          if (data.isEmptyOrNull) {
                            return;
                          }
                          copyClipboard(data);
                        },
                        child: Row(
                          children: [
                            controller.registrationData.value == null ||
                                    controller.registrationData.value.privateKey
                                        .isEmptyOrNull
                                ? Container()
                                : "Private Key :"
                                    .text
                                    .color(kPrimaryColor)
                                    .bold
                                    .size(Vx.dp16)
                                    .make(),
                            5.widthBox,
                            "${controller.registrationData.value.privateKey}"
                                .text
                                .color(kPrimaryColor)
                                .size(Vx.dp16)
                                .make()
                                .box
                                .width(context.percentWidth * 60)
                                .make()
                          ],
                        ).centered(),
                      ),
              ],
            ).px12(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AgreementInput.id);
              },
              child: Container(
                width: 200,
                height: 150,
                child: IconContent(
                  icon: FontAwesomeIcons.penSquare,
                  label: 'New Agreement',
                ),
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, PastAgreement.id);
                Get.to(PastAgreement(), binding: PastAgreementBinding());
              },
              child: Container(
                width: 200,
                height: 150,
                child: IconContent(
                  icon: FontAwesomeIcons.penSquare,
                  label: 'Past Agreements',
                ),
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ]),
    );
  }
}

class IconContent extends StatelessWidget {
  IconContent({this.icon, this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
