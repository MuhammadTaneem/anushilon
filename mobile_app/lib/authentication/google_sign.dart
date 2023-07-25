import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/urtils.dart';
import 'login.dart';

class GoogleAuth{
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  getGoogleSignIn(){
    return _googleSignIn;
  }

  logout(context)  async {


    _googleSignIn.disconnect();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    clearStorage();
    // storage.deleteItem("userDisplayName");
    // storage.deleteItem("userId");
    // storage.deleteItem("userEmail");
    // storage.deleteItem("userPhotoUrl");
    // storage.setItem("isAuthorized", false);

  }




}
