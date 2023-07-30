import 'package:http/http.dart' as http;
import '../utils/connectivityCheck.dart';
import '../utils/constants.dart';
import '../utils/show_message.dart';


Map<String, String> get headers => {
  'Content-Type': 'application/json; charset=UTF-8',
};
String apiUrl = '${Constants.apiRootUrl}mcq/';

getMcq(Map<String, dynamic> data ) async {

  try {
    if (await getConnectionStatus()) {

      bool firstQur = true;

      data.forEach((key, value) {
        if (firstQur) {
          apiUrl += '?$key=$value';
          firstQur = false;
        } else {
          apiUrl += '&$key=$value';
        }
      });
      // final Uri uri = Uri.parse(apiUrl).replace(queryParameters: data);
      final Uri uri = Uri.parse(apiUrl);
        return  await http.get( uri,headers: headers);
    }
  } catch (error) {
    showErrorMessage(msg: 'সার্ভারে সমস্যা হয়েছে');
  }

}