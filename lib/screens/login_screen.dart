import 'dart:developer';

import 'package:consentify/constants.dart';
import 'package:consentify/get/controller/main_controller.dart';
import 'package:consentify/helper/widgets.dart';
import 'package:consentify/model/login_session_data.dart';
import 'package:consentify/model/registration_data.dart';
import 'package:consentify/screens/home_screen.dart';
import 'package:consentify/screens/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:supabase/supabase.dart';
import 'package:injector/injector.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

import '../model/user_data.dart';
import '../utils/api_utils.dart';
// import 'package:consentify/main.dart';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flash_chat/components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();

  bool isLoad = false;

  final controller = Get.find<MainController>();

  var connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: PeerMeta(
      name: 'WalletConnect',
      description: 'WalletConnect Developer App',
      url: baseUrl,
      icons: [
        'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
      ],
    ),
  );

  var _session, _uri;

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(
            chainId: 5,
            onDisplayUri: (uri) async {
              _uri = uri;

              await launchUrlString(uri, mode: LaunchMode.externalApplication);
            });
        setState(() {
          _session = session;

          if (session.accounts[0].isEmptyOrNull) {
            showSnackWithoutContext("Failed to login!");

            return;
          }
          controller.loginSession.value = LoginSessionData(
              chainId: session.chainId.toString(),
              account: session.accounts[0]);

          controller.registrationData.value =
              RegistrationData(publicKey: session.accounts[0]);

          controller.connector.value = connector;

          setState(() {
            isLoad = true;
          });

          controller.generateQrCode((UserData value) {
            if (value == null) {
              setState(() {
                isLoad = false;
              });
              showSnackWithoutContext("User not found!");
              return;
            }

            controller.userData.value = value;

            Navigator.pushNamed(context, HomeScreen.id);
          });
        });
      } catch (exp) {
        print(exp);
        showSnackWithoutContext("Failed to login or Install MetaMask app!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // connector.on(
    //     'connect',
    //     (session) => setState(
    //           () {
    //             _session = _session;
    //           },
    //         ));
    // connector.on(
    //     'session_update',
    //     (payload) => setState(() {
    //           _session = payload;
    //           log(payload.accounts[0]);
    //           log(payload.chainId);
    //         }));
    // connector.on(
    //     'disconnect',
    //     (payload) => setState(() {
    //           _session = null;
    //         }));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: isLoad
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 100),
                                child: Text(
                                  "Consentify",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontFamily: 'Pacifico',
                                      fontSize: 40.0,
                                      height: 1.4,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ).centered(),
                              SizedBox(height: 90),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 40),
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: <Widget>[
                              //       Padding(
                              //         padding: const EdgeInsets.only(right: 16),
                              //         child: Icon(
                              //           Icons.alternate_email,
                              //           color: kPrimaryColor,
                              //         ),
                              //       ),
                              //       Expanded(
                              //         child: TextFormField(
                              //             // ignore: missing_return
                              //             validator: (value) {
                              //               if (value == null || value.isEmpty) {
                              //                 ScaffoldMessenger.of(context)
                              //                     .showSnackBar(SnackBar(
                              //                         content:
                              //                             Text('Invalid Email')));
                              //               }
                              //             },
                              //             cursorColor: Colors.white,
                              //             style: TextStyle(color: Colors.white),
                              //             onChanged: (value) {
                              //               email = value;
                              //             },
                              //             decoration: kTextFieldDecoration.copyWith(
                              //                 hintText: 'Email')),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: <Widget>[
                              //     Padding(
                              //       padding: const EdgeInsets.only(right: 16),
                              //       child: Icon(
                              //         Icons.lock,
                              //         color: kPrimaryColor,
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: TextFormField(
                              //         // ignore: missing_return
                              //         validator: (value) {
                              //           if (value == null || value.isEmpty) {
                              //             ScaffoldMessenger.of(context).showSnackBar(
                              //                 SnackBar(
                              //                     content: Text('Invalid Password')));
                              //           }
                              //         },
                              //         obscureText: true,
                              //         cursorColor: Colors.white,
                              //         style: TextStyle(color: Colors.white),
                              //         onChanged: (value) {
                              //           password = value;
                              //         },
                              //         decoration: kTextFieldDecoration.copyWith(
                              //           hintText: "Password",
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: 50),
                              Container(
                                width: 250,
                                child: MaterialButton(
                                  padding: EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  onPressed: () async {
                                    // setState(() {
                                    //   showSpinner = true;
                                    // });
                                    // if (email == null || password == null) {
                                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    //       content: Text(
                                    //           'Missing data, please enter valid email and password')));
                                    // }

                                    // final response = await Injector.appInstance
                                    //     .get<SupabaseClient>()
                                    //     .auth
                                    //     .signUp(email, password);
                                    // if (response.error != null) {
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //       SnackBar(
                                    //           content: Text(response.error.message)));
                                    // } else {
                                    //   Navigator.pushNamed(context, HomeScreen.id);
                                    // }
                                    // setState(() {
                                    //   showSpinner = false;
                                    // });

                                    loginUsingMetamask(context);
                                  },
                                  child: Text('Connect with Metamask'),
                                  color: kPrimaryColor,
                                ),
                              ).centered(),
                              SizedBox(height: 30),
                              Container(
                                width: 250,
                                child: MaterialButton(
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    onPressed: () async {
                                      Navigator.pushNamed(
                                          context, Registerpage.id);
                                      // setState(() {
                                      //   showSpinner = true;
                                      // });
                                      // if (email == null || password == null) {
                                      //   ScaffoldMessenger.of(context).showSnackBar(
                                      //       SnackBar(
                                      //           content: Text(
                                      //               'Missing data, please enter valid email and password')));
                                      // }
                                      // final response = await Injector.appInstance
                                      //     .get<SupabaseClient>()
                                      //     .auth
                                      //     .signIn(email: email, password: password);
                                      // if (response.error != null) {
                                      //   ScaffoldMessenger.of(context).showSnackBar(
                                      //       SnackBar(
                                      //           content:
                                      //               Text(response.error.message)));
                                      // } else if (response != null &&
                                      //     response.user != null) {
                                      //   Navigator.pushNamed(context, HomeScreen.id);
                                      // }
                                      // setState(() {
                                      //   showSpinner = false;
                                      // });
                                    },
                                    child: Text('Create Account'),
                                    color: kPrimaryColor),
                              ).centered(),
                              SizedBox(height: 30),
                              // TextButton(
                              //     onPressed: () {},
                              //     child: Text("Forgot Password ?",
                              //         style: TextStyle(color: Colors.white))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
