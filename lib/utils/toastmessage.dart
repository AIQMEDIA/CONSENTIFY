import 'package:consentify/utils/toastcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSucssesfulToast() => Fluttertoast.showToast(
    msg: "Form Submit Sucseesfully",
    timeInSecForIosWeb: 2,
    toastLength: Toast.LENGTH_SHORT,
    fontSize: 18,
    gravity: ToastGravity.TOP,
    backgroundColor: ColorUtils.ksucssesful);

void showErrorToast() => Fluttertoast.showToast(
    msg: "please filed the all details",
    timeInSecForIosWeb: 2,
    toastLength: Toast.LENGTH_SHORT,
    fontSize: 18,
    gravity: ToastGravity.TOP,
    backgroundColor: ColorUtils.kerror);
