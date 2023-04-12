import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFF202020);
const kPrimaryColor = Color(0xFFFF8073);

const kQuestionStyle = TextStyle(
    color: kPrimaryColor, fontWeight: FontWeight.w500, fontSize: 17.0);

const kAnswerStyle = TextStyle(fontSize: 17.0);

var kTextFieldDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.grey.withOpacity(0.2),
    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kBackgroundColor, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ));
