import 'package:http/http.dart' as http;
import '../authentication/login.dart';
import '../utils/connectivityCheck.dart';
import '../utils/constants.dart';
import '../utils/show_message.dart';

String apiUrl = '${Constants.apiRootUrl}exam/';

getSingleExam(int id) async {

  try {
    if (await getConnectionStatus()) {
      final Uri uri = Uri.parse('$apiUrl$id/');
      return  await http.get( uri,headers: headers);
    }
  } catch (error) {
  }

}