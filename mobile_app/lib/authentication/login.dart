import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../homePage/homepage.dart';
import '../utils/urtils.dart';
import 'google_sign.dart';

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
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final LocalStorage storage = await getStorage();
        await storage.setItem("userDisplayName", "${user.displayName}");
        await storage.setItem("userId", user.id);
        await storage.setItem("userEmail", user.email);
        await storage.setItem("userPhotoUrl", "${user.photoUrl}");
        await storage.setItem("isAuthorized", true);
        pageChange(HomePage.routeName);
      } else {
        final LocalStorage storage = await getStorage();
        storage.setItem("isAuthorized", false);
        print("something wrong");
        pageChange("/");
      }
    } catch (error) {
      final LocalStorage storage = await getStorage();
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
