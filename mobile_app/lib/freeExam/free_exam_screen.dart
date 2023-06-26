import 'package:flutter/material.dart';

class FreeExamScreen extends StatelessWidget {
  static const routeName = '/free_exam_screen';
  const FreeExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ফ্রী পরিক্ষা"),
      ),
      body: Container(
        child: Center(
          child: Text("কাজ চলমান...।"),
        ),
      ),
    );
  }
}
