import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toastMsg(String errorMsg) {
    Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0XFF454545),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
