import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/utils/show_message.dart';

Future<bool> getConnectionStatus() async {
  final connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult == ConnectivityResult.none) {
    showErrorMessage(msg: 'ইন্টারনেট চালু করুন');
    return false;
  }
  return true;

}