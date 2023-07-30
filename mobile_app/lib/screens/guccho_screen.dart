import 'package:flutter/material.dart';

import '../widgets/exam_package_view.dart';

class GucchoScreen extends StatelessWidget {
  static const routeName = '/guccho_screen';
  const GucchoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("গুচ্ছ"),
        centerTitle: true,
      ),
      body:   const Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(children: [
          ExamPackageView(category: 'guccho',)
        ],),
      ),
    );
  }
}
