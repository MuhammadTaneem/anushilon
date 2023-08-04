import 'package:http/http.dart' as http;
import '../authentication/login.dart';
import '../utils/connectivityCheck.dart';
import '../utils/constants.dart';
import '../utils/show_message.dart';
import '../utils/urtils.dart';


// Map<String, String> get headers => {
//   'Content-Type': 'application/json; charset=UTF-8',
// };
String apiUrl = '${Constants.apiRootUrl}mcq/';

getMcq(Map<String, dynamic> data ) async {

  try {
    if (await getConnectionStatus()) {
      final Uri uri = Uri.parse(queryParamsSetter(data,apiUrl));
        return  await http.get( uri,headers: headers);
    }
  } catch (error) {
  }

}