import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showErrorMessage({required String msg,  gravity=ToastGravity.CENTER, fontSize=18.0, textColor=Colors.white, bgColor=Colors.red}){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 5,
    backgroundColor: bgColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}



showSuccessMessage({required String msg,  gravity=ToastGravity.CENTER, fontSize=18.0, textColor=Colors.white, bgColor=Colors.green}){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 5,
    backgroundColor: bgColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}