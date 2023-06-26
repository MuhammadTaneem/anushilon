import 'package:flutter/material.dart';

class MedicalScreen extends StatelessWidget {
  static const routeName = '/medical_screen';
  const MedicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("মেডিকেল"),
      ),
      body: Container(
        child: Center(
          child: Text("কাজ চলমান...।"),
        ),
      ),
    );
  }
}
