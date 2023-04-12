import 'package:flutter/material.dart';

import 'package:consentify/constants.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1. Is this app for men or women?', style: kQuestionStyle),
            Text('It is for everyone. (if they are atleast of proper age).',
                style: kAnswerStyle),
            SizedBox(height: 10.0),
            Text('2. Do both parties need to have the app installed to use it?',
                style: kQuestionStyle),
            Text('Just one partner needs the app.', style: kAnswerStyle),
            SizedBox(height: 10.0),
            Text('3. What is the minimum age to use Consentify?',
                style: kQuestionStyle),
            Text(
                'Depends on your country. If  you are in the U.S, all parties must be at least 18 in accordance with Federal Law',
                style: kAnswerStyle),
            SizedBox(height: 10.0),
            Text(
                "4. If the app is only on one person's phone how do I get a copy of the Consent Agreement?",
                style: kQuestionStyle),
            Text(
                "During the creation of the agreement the Consenter has the option to put in an e-mail for the Consent Agreement to be sent to.The Agreement can also be saved to the Consentee's phone as an image file. Remember not to share them with anyone else though, or you can be sued/charged in some jurisdictions.",
                style: kAnswerStyle),
          ],
        ),
      ),
    );
  }
}
