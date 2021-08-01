import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:consentify/db/database.dart';
import 'package:consentify/model/agreement.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

final supabaseClient = Injector.appInstance.get<SupabaseClient>();
final user = supabaseClient.auth.user();
final userEmail = user.email;

class AgreementDetailPage extends StatefulWidget {
  final int agreementId;

  const AgreementDetailPage({
    Key key,
    @required this.agreementId,
  }) : super(key: key);

  @override
  _AgreementDetailPageState createState() => _AgreementDetailPageState();
}

class _AgreementDetailPageState extends State<AgreementDetailPage> {
  Agreement agreement;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshAgreement();
  }

  Future refreshAgreement() async {
    setState(() => isLoading = true);

    this.agreement =
        await AgreementDatabase.instance.readAgreement(widget.agreementId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [reviewButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      "CONSENT AGREEMENT",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      DateFormat.yMMMd().format(agreement.agreementTime),
                      style: TextStyle(color: Colors.white38),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "My name is ${agreement.consentGiver} and I hereby consent to engaging in sexual activity with ${agreement.consentAsker} on ${agreement..agreementTime}. I hereby confirm that we both are atleast 18 years old. Neither of us are intoxicated or in duress. We will not share this agreement with anyone but ourselves, law enforcement or a lawyer.",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget reviewButton() => TextButton(
      onPressed: () {
        createAlertDialog1(context);
      },
      child: Text(
        'Review',
        style: TextStyle(color: Colors.white),
      ));

  createAlertDialog1(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you still satisfied with this agreement?'),
            actions: [
              MaterialButton(
                  elevation: 5.0,
                  child: Text('YES'),
                  onPressed: () {
                    Navigator.pop(context);
                    createAlertDialog2(context);
                  }),
              MaterialButton(
                  elevation: 5.0,
                  child: Text('NO'),
                  onPressed: () {
                    if (userEmail == agreement.consentGiverEmail) {
                      sendMail();
                    }
                    Navigator.pop(context);
                    createAlertDialog3(context);
                  })
            ],
          );
        });
  }

  createAlertDialog2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cool!'),
            actions: [
              MaterialButton(
                  elevation: 5.0,
                  child: Text('CLOSE'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  createAlertDialog3(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                'Please contact your nearest police station if you feel your consent has been violated.'),
            actions: [
              MaterialButton(
                  elevation: 5.0,
                  child: Text('CLOSE'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  sendMail() async {
    String username = 'consentify@gmail.com';
    String password = 'Sucharita1234';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Consentify')
      ..recipients.add(agreement.consentAskerEmail)
      ..subject = 'Revoked Consent!'
      ..text =
          'This is to inform you that the party that gave consent to you has revoked their consent. You are advised to contact them via text and also keep a record of your conversation for legal purposes.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
