import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../authentication/login.dart';
import '../utils/connectivityCheck.dart';
import '../utils/constants.dart';
import '../utils/show_message.dart';
import '../utils/urtils.dart';


String baseUrl = '${Constants.apiRootUrl}package/';


getExamPackage(Map<String, dynamic> data ) async {
  String apiUrl = '${baseUrl}exam_package/';

  try {
    if (await getConnectionStatus()) {
      final Uri uri = Uri.parse(queryParamsSetter(data,apiUrl));
      return  await http.get( uri,headers: headers);
    }
  } catch (error) {
    if (kDebugMode) {
      print(error);
    }
  }

}