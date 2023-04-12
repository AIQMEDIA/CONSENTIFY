import 'package:flutter/cupertino.dart';

final fullNameController = TextEditingController();
final emailController = TextEditingController();
final birthDateController = TextEditingController();
final mobileNoController = TextEditingController();

var fullname = " ";
var email = " ";
var birthdate = " ";
var mobileno = " ";

// ignore: non_constant_identifier_names
ClearText() {
  fullNameController.clear();
  emailController.clear();
  birthDateController.clear();
  mobileNoController.clear();
}
