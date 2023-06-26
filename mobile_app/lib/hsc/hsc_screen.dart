import 'package:flutter/material.dart';

class HscScreen extends StatelessWidget {
  static const routeName = '/hsc_screen';
  const HscScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("এইচ এস সি"),
      ),
      body: Container(
        child: Center(
          child: Text("কাজ চলমান...।"),
        ),
      ),
    );
  }
}
