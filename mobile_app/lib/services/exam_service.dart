import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../authentication/login.dart';
import '../utils/connectivityCheck.dart';
import '../utils/constants.dart';


getSingleExam(int id) async {
  try {
    if (await getConnectionStatus()) {
      final Uri uri = Uri.parse('${Constants.apiRootUrl}exam/$id/');
      return await http.get(uri, headers: headers);
    }
  } catch (error) {
    if (kDebugMode) {
      print(error);
    }
  }
}

submitExam(data) async {
  try {
    if (await getConnectionStatus()) {
      final Uri uri = Uri.parse('${Constants.apiRootUrl}exam_submissions/');
      String aa = jsonEncode(data);
      print(aa);
      return await http.post(uri, headers: headers,body: jsonEncode(data),);
    }
  } catch (error) {
    if (kDebugMode) {
      print(error);
    }
  }
}
