import 'dart:convert';

import 'package:localstorage/localstorage.dart';

import '../authentication/login.dart';
import '../utils/connectivityCheck.dart';
import '../utils/constants.dart';
import '../utils/show_message.dart';
import '../utils/urtils.dart';
import 'package:http/http.dart' as http;

//
// Map<String, String> get headers => {
//       'Content-Type': 'application/json; charset=UTF-8',
//     };

responseTOStorage(response) async {
  var body = jsonDecode(response.body);
  final LocalStorage storage = await getStorage();
  await storage.setItem("userGroup", body["group"]);
  await storage.setItem("userDisplayName", "${body['name']}");
  await storage.setItem("userId", body["id"]);
  await storage.setItem("userEmail", body["email"]);
  await storage.setItem("userPhotoUrl", body["photo_url"]);
  await storage.setItem("userGoogleId", body["google_id"]);
  await storage.setItem("balance", body["balance"]);
  await storage.setItem("isAuthorized", true);
}

updateProfile(data) async {
  try {
    if (await getConnectionStatus()) {
      final LocalStorage storage = await getStorage();
      var userId = 0;
      userId = await storage.getItem("userId");
      if (userId > 0) {
        final apiUrl = Uri.parse('${Constants.apiRootUrl}student/$userId/');
        http
            .put(
          apiUrl,
          headers: headers,
          body: jsonEncode(data),
        )
            .then((response) async {
          if (response.statusCode == 200) {
            responseTOStorage(response);
            showSuccessMessage(msg: "সফল ভাবে আপডেট হয়েছে");
          } else {
            var body = jsonDecode(response.body);
            showErrorMessage(msg: "${body['error']}");
          }
        }).catchError((error) {
          showErrorMessage(msg: "আপডেট ব্যার্থ হয়েছে, পুনঃরায় চেস্টা করুন");
          // Handle the error
          print('Error: $error');
        });
      } else {
        final LocalStorage storage = await getStorage();
        storage.setItem("isAuthorized", false);
        showErrorMessage(msg: 'লগিন ব্যার্থ হয়েছে, পুনঃরায় চেস্টা করুন');
      }
    }
    // debugPrint("user is ");
  } catch (error) {
    final LocalStorage storage = await getStorage();

    storage.setItem("isAuthorized", false);

    print('Login error: $error');
  }
}
