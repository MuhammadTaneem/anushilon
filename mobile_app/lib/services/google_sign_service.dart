import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/urtils.dart';
import '../authentication/login.dart';

class GoogleAuthService{
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  getGoogleSignIn(){
    return _googleSignIn;
  }

  logout(BuildContext context)  async {
    _googleSignIn.disconnect();
    clearStorage();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );

  }

}
