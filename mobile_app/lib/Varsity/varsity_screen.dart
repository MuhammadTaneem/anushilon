import 'package:flutter/material.dart';

class VarsityScreen extends StatelessWidget {
  static const routeName = '/varsity_screen';
  const VarsityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ভার্সিটি"),
      ),
      body: Container(
        child: Center(
          child: Text("কাজ চলমান...।"),
        ),
      ),
    );
  }
}
