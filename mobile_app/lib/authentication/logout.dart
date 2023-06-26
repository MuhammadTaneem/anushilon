// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:mobile_app/authentication/google_sign.dart';
// import 'package:mobile_app/authentication/login.dart';
// import '../utils/urtils.dart';
//
// logout(context) async {
//
//   var googleAuth = GoogleAuth();
//   final GoogleSignIn _googleSignIn = googleAuth.getGoogleSignIn();
//   _googleSignIn.disconnect();
//   final LocalStorage storage = await getStorage();
//   storage.deleteItem("userDisplayName");
//   storage.deleteItem("userId");
//   storage.deleteItem("userEmail");
//   storage.deleteItem("userPhotoUrl");
//   storage.setItem("isAuthorized", false);
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => LoginPage()),
//   );
// }