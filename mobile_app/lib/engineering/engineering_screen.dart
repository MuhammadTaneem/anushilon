import 'package:flutter/material.dart';

class EngineeringScreen extends StatelessWidget {
  static const routeName = '/engineering_screen';
  const EngineeringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ইঞ্জিনিয়ারিং"),
      ),
      body: Container(
        child: Center(
          child: Text("কাজ চলমান...।"),
        ),
      ),
    );
  }
}
