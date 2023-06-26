import 'package:flutter/material.dart';

class GucchoScreen extends StatelessWidget {
  static const routeName = '/guccho_screen';
  const GucchoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("গুচ্ছ"),
      ),
      body: Container(
        child: Center(
          child: Text("কাজ চলমান...।"),
        ),
      ),
    );
  }
}
