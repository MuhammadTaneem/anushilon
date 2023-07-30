import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile_app/utils/show_message.dart';
import '../screens/home_page_screen.dart';
import '../services/profile_service.dart';
import '../utils/connectivityCheck.dart';
import '../utils/urtils.dart';
import '../widgets/loader_widget.dart';
import '../services/google_sign_service.dart';
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
  late GoogleAuthService googleAuth;
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
      if (await getConnectionStatus()) {
        final user = await _googleSignIn.signIn();
        if (user != null) {
          var data = {
            'name': "${user.displayName}",
            'google_id': user.id,
            'email': user.email,
            'photo_url': "${user.photoUrl}",
          };

          final apiUrl = Uri.parse('${Constants.apiRootUrl}student/');
          http
              .post(
            apiUrl,
            headers: headers,
            body: jsonEncode(data),
          )
              .then((response) async {
            responseTOStorage(response);
            showSuccessMessage(msg: "লগিন সফল হয়েছে");
            pageChange(HomePageScreen.routeName);
          }).catchError((error) {
            showErrorMessage(msg: "লগিন ব্যার্থ হয়েছে, পুনঃরায় চেস্টা করুন");
            pageChange("/");
            // Handle the error
            print('Error: $error');
          });
        } else {
          final LocalStorage storage = await getStorage();
          storage.setItem("isAuthorized", false);
          showErrorMessage(msg: 'সার্ভার সমস্যা ,কিছুক্ষণ পর পুনঃরায় চেস্টা করুন');
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
    googleAuth = GoogleAuthService();
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
            ? CentralLoading()// Show loading indicator if _isLoading is true
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
