import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

void showSnackWithoutContext(String msg) {
  Get.snackbar("Information", msg,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
      backgroundColor: Vx.black);
}

dlog(String msg) {
  if (kDebugMode) {
    log(msg);
  }
}
