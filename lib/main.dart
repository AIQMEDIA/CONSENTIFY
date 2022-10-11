// import 'package:consentify/screens/home_screen.dart';
import 'package:consentify/screens/agreement_input.dart';
// import 'package:consentify/screens/review_screen.dart';
import 'package:consentify/screens/home_screen.dart';
import 'package:consentify/screens/past_agreement.dart';
import 'package:consentify/screens/qrcode.dart';
import 'package:consentify/screens/qrview.dart';
import 'package:flutter/material.dart';
import 'package:consentify/screens/welcome_screen.dart';
import 'package:consentify/constants.dart';
import 'package:consentify/screens/login_screen.dart';
import 'package:supabase/supabase.dart';
import 'package:injector/injector.dart';

void main() {
  const supabaseURL = 'https://jedxvgzgmyafjkibvqyx.supabase.co';
  const supabaseKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyMDc0MzI5NSwiZXhwIjoxOTM2MzE5Mjk1fQ.MAGvKtBP8se7B6PLVTNTmQgbzB6SLXs_WWlmrSP6XOM';
  final supabaseClient = SupabaseClient(
    supabaseURL, // <- Copy and paste your URL
    supabaseKey, // <- Copy and paste your public key
  );

  Injector.appInstance.registerSingleton<SupabaseClient>(() => supabaseClient);
  runApp(Consentify());
}

class Consentify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme: TextTheme(
            headline4: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(color: kPrimaryColor),
            headline5:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        initialRoute: HomeScreen.id,
        // WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          AgreementInput.id: (context) => AgreementInput(),
          PastAgreement.id: (context) => PastAgreement(),
          Qrcode.id: (context) => Qrcode(),
          QrScanPage.id: (context) => QrScanPage(),
        });
  }
}
