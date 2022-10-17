import 'package:consentify/screens/home_screen.dart';
import 'package:consentify/screens/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:consentify/constants.dart';
import 'package:consentify/screens/login_screen.dart';
import 'package:injector/injector.dart';
import 'package:supabase/supabase.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

final supabaseClient = Injector.appInstance.get<SupabaseClient>();
final user = supabaseClient.auth.user();

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Consentify.jpeg'),
              fit: BoxFit.cover)),
      padding: EdgeInsets.only(top: 110.0),
      child: Column(
        children: [
          Text(
            "Consentify",
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontFamily: 'Pacifico',
                fontSize: 40.0,
                height: 1.4,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 500),
          MaterialButton(
            child: Container(
              width: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get Started",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            color: kPrimaryColor,
            onPressed: () {
              if (user != null) {
                Navigator.pushNamed(context, HomeScreen.id);
              } else {
                Navigator.pushNamed(context, Registerpage.id);
              }
            },
          ),
        ],
      ),
    ));
  }
}
