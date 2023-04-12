import 'dart:convert';

import 'package:consentify/helper/widgets.dart';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';

Future<String> contractDecoder({@required String contractData}) async {
  final String data0 = contractData.replaceAll('0x', '');

  var data = hex.decode(data0);
  var data1 = utf8.decode(data);
  dlog('contract decode data -> $data1');

  return data1;
}
