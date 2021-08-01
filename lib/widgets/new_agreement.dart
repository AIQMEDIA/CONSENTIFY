import 'package:consentify/screens/agreement_input.dart';
import 'package:consentify/screens/past_agreement.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:consentify/constants.dart';

class NewAgreement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                Navigator.pushNamed(context, PastAgreement.id);
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
