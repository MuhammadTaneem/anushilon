import 'package:flutter/material.dart';

class ParticipatedScreen extends StatelessWidget {
  static const routeName = '/participated_exam_screen';
  const ParticipatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("পুর্ববর্তী পরিক্ষা"),
      ),
      body: Container(
        child: Center(
          child: Text("কাজ চলমান...।"),
        ),
      ),
    );
  }
}
