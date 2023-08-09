import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../authentication/login.dart';
import '../utils/connectivityCheck.dart';
import '../utils/constants.dart';


String apiUrl = '${Constants.apiRootUrl}question_bank/';

getQuestionBankList(Map<String, dynamic> data ) async {

  try {
    if (await getConnectionStatus()) {
      final Uri uri = Uri.parse('${apiUrl}list/').replace(queryParameters: data);
      return  await http.get( uri,headers: headers);
    }
  } catch (error) {
    if (kDebugMode) {
      print(error);
    }
  }
}


getQuestionBankDetails(int id ) async {

  try {
    if (await getConnectionStatus()) {
      final Uri uri = Uri.parse('$apiUrl$id/');
      return  await http.get( uri,headers: headers);
    }
  } catch (error) {
    if (kDebugMode) {
      print(error);
    }
  }
}