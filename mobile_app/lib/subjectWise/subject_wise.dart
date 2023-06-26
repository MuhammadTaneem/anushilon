import 'package:flutter/material.dart';

class SubjectWiseScreen extends StatefulWidget {
  static const routeName = '/subject_wise_screen';
  const SubjectWiseScreen({super.key});

  @override
  State<SubjectWiseScreen> createState() => _SubjectWiseScreenState();
}

class _SubjectWiseScreenState extends State<SubjectWiseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("বিষয় ভিত্তিক"),
      ),
      body: Container(
        child: Center(
          child: Text("কাজ চলমান...।"),
        ),
      ),
    );
  }
}
