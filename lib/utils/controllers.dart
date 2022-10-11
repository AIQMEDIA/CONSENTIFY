import 'package:flutter/cupertino.dart';

final askingconsentController = TextEditingController();
final givingconsentController = TextEditingController();
final askingemailController = TextEditingController();
final givinggemailController = TextEditingController();

var askingconsent = " ";
var givingconsent = " ";
var askingemail = " ";
var givingemail = " ";

// ignore: non_constant_identifier_names
ClearText() {
  askingconsentController.clear();
  givingconsentController.clear();
  askingemailController.clear();
  givinggemailController.clear();
}

// ignore: non_constant_identifier_names
QrConsents() {
  givingconsentController.text;
  givinggemailController.text;
}
