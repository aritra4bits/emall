import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AppUtils {
  static void showToast(String? text, {Color color = Colors.red}) {
    if (text == null) return;
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
