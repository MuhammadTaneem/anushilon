import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_app/utils/show_message.dart';
import '../homePage/homepage.dart';
import '../profile/profile_service.dart';
import '../utils/connectivityCheck.dart';
import '../utils/urtils.dart';
import 'google_sign.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

Map<String, String> get headers => {
  'Content-Type': 'application/json; charset=UTF-8',
};
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GoogleAuth googleAuth;
  late GoogleSignIn _googleSignIn;

  bool _isLoading = false;

  pageChange(String router) {
    Navigator.pushReplacementNamed(context, router);
  }

  void _handleSignIn() async {
    if (mounted) {
      setState(() {
        _isLoading = true; // Start loading
      });
    }

    try {
      if(await getConnectionStatus()){
        final user = await _googleSignIn.signIn();
        if (user != null) {
          // final LocalStorage storage = await getStorage();
          // await storage.setItem("userDisplayName", "${user.displayName}");
          // await storage.setItem("userId", user.id);
          // await storage.setItem("userEmail", user.email);
          // await storage.setItem("userPhotoUrl", "${user.photoUrl}");
          // await storage.setItem("isAuthorized", true);

          var data = {
           'name': "${user.displayName}",
          'google_id': user.id,
          'email': user.email,
          'photo_url': "${user.photoUrl}",
        };


          final apiUrl = Uri.parse('${Constants.apiRootUrl}student/');
          http.post(apiUrl,headers: headers, body: jsonEncode(data),).then((response) async {
            responseTOStorage(response);
            // var body   =  jsonDecode(response.body);
            showSuccessMessage(msg: "লগিন সফল হয়েছে");
            // final LocalStorage storage = await getStorage();
            // await storage.setItem("userDisplayName", body['name']);
            // await storage.setItem("userId", body['id']);
            // await storage.setItem("userGoogleId", body['google_id']);
            // await storage.setItem("userEmail", body['email']);
            // await storage.setItem("userGroup", body['group']);
            // await storage.setItem("userPhotoUrl", body['photo_url']);
            // await storage.setItem("isAuthorized", true);
            pageChange(HomePage.routeName);
          }).catchError((error) {
            showErrorMessage(msg: "লগিন ব্যার্থ হয়েছে, পুনঃরায় চেস্টা করুন");
              pageChange("/");
            // Handle the error
            print('Error: $error');
          });



        } else {
          final LocalStorage storage = await getStorage();
          storage.setItem("isAuthorized", false);
          showErrorMessage(msg: 'লগিন ব্যার্থ হয়েছে, পুনঃরায় চেস্টা করুন');
          pageChange("/");
        }

      }
      // debugPrint("user is ");

    } catch (error) {
      final LocalStorage storage = await getStorage();
      showErrorMessage(msg: 'সার্ভারে সমস্যা হয়েছে');
      storage.setItem("isAuthorized", false);
      print('Login error: $error');
      pageChange("/");
    }

    if (mounted) {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  void initState() {
    super.initState();
    googleAuth = GoogleAuth();
    _googleSignIn = googleAuth.getGoogleSignIn();
  }

  @override
  void dispose() {
    // Cancel any active work or cleanup resources here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? SpinKitSpinningLines(
              color: Theme.of(context).colorScheme.secondary,
              size: 60.0,
            ) // Show loading indicator if _isLoading is true
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/launcher.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _handleSignIn,
              icon: Image.asset(
                'assets/icons/google.png',
                width: 40,
                height: 40,
              ),
              label: const Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                minimumSize: const Size(250, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
