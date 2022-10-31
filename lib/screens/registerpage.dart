import 'dart:io';
import 'package:consentify/api/api_services/bLoc.dart';
import 'package:consentify/constants.dart';
import 'package:consentify/screens/home_screen.dart';
import 'package:consentify/utils/controllers.dart';
import 'package:consentify/utils/toastmessage.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({Key key}) : super(key: key);
  static String id = 'Register_screen';
  @override
  State<Registerpage> createState() => _RegisterpageState();
}

var xpub;
var mnemonic;

class _RegisterpageState extends State<Registerpage> {
  bool showSpinner = true;
  final _registerKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _registerKey,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 80),
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
                      ),
                      SizedBox(height: 90),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.account_circle,
                                color: kPrimaryColor,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                  // ignore: missing_return
                                  controller: fullnameController,
                                  validator: (String value) {
                                    if (value != null && value.isEmpty) {
                                      return " Full_name can't be empty";
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  // onChanged: (value) {
                                  //   email = value;
                                  // },
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Full_name')),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.alternate_email,
                                color: kPrimaryColor,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                  // ignore: missing_return
                                  controller: emailController,
                                  validator: (String value) {
                                    if (value != null && value.isEmpty) {
                                      return "E-mail can't be empty";
                                    } else if (!value.contains('@')) {
                                      return 'please Enter valid Email';
                                    } else if (!value.contains('.')) {
                                      return 'please Enter valid Email';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  // onChanged: (value) {
                                  //   email = value;
                                  // },
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Email')),
                            ),
                          ],
                        ),
                      ),
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
                      //         // onChanged: (value) {
                      //         //   password = value;
                      //         // },
                      //         decoration: kTextFieldDecoration.copyWith(
                      //           hintText: "Password",
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.cake,
                                color: kPrimaryColor,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                  // ignore: missing_return
                                  controller: birthdateController,
                                  validator: (String value) {
                                    if (value != null && value.isEmpty) {
                                      return "Birth_date can't be empty";
                                    } else if (!value.contains('/')) {
                                      return 'Birthdate should be in this format dd/mm/yyyy';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  // onChanged: (value) {
                                  //   email = value;
                                  // },
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Date of birthday')),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.phone,
                                color: kPrimaryColor,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                  // ignore: missing_return
                                  controller: mobilenoController,
                                  validator: (String value) {
                                    if (value != null && value.isEmpty) {
                                      return "Mobile no can't be empty";
                                    } else if (value != null &&
                                        value.length < 10) {
                                      return 'please Enter valid mobile no';
                                    } else if (value != null &&
                                        value.length > 10) {
                                      return 'Mobile No Should be atleast 10 character';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  // onChanged: (value) {
                                  //   email = value;
                                  // },
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Mobile_no')),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   height: 54,
                      //   width: 200,
                      //   child: MaterialButton(
                      //     padding: EdgeInsets.all(15.0),
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10.0)),
                      //     onPressed: () {
                      //       pickfile();
                      //     },
                      //     child: Text(
                      //       'choose',
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold, fontSize: 18),
                      //     ),
                      //     color: kPrimaryColor,
                      //   ),
                      // ),

                      SizedBox(height: 8),
                      Container(
                        height: 54,
                        width: 200,
                        child: MaterialButton(
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            if (_registerKey.currentState.validate()) {
                              showRegisterToast();
                              getEthereumwalletbloc.getEthereumwalletsink();
                              Navigator.pushNamed(context, HomeScreen.id);
                              ClearText();
                              setState(() {
                                showSpinner = true;
                              });
                            }

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
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

FilePickerResult result;
String _filename;
PlatformFile pickedfile;
bool isLoading = false;
File fileToDisplay;

Future<void> pickfile() async {
  try {
    result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (result != null) {
      _filename = result.files.first.name;
      pickedfile = result.files.first;
      fileToDisplay = File(pickedfile.path.toString());
      print('File name$_filename');
    }
  } catch (e) {
    print(e);
  }
}
