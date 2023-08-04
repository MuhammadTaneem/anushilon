import 'package:flutter/material.dart';

import '../widgets/exam_package_view.dart';

class MedicalScreen extends StatelessWidget {
  static const routeName = '/medical_screen';
  const MedicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("মেডিকেল"),
        centerTitle: true,
      ),
      body:  const Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(children: [
          Expanded(child: ExamPackageView(category: 'medical'))
        ],),
      ),
    );
  }
}
