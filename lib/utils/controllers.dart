import 'package:flutter/cupertino.dart';

final fullnameController = TextEditingController();
final emailController = TextEditingController();
final birthdateController = TextEditingController();
final mobilenoController = TextEditingController();

var fullname = " ";
var email = " ";
var birthdate = " ";
var mobileno = " ";

// ignore: non_constant_identifier_names
ClearText() {
  fullnameController.clear();
  emailController.clear();
  birthdateController.clear();
  mobilenoController.clear();
}
