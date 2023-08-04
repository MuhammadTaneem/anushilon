import 'package:flutter/material.dart';

import '../widgets/exam_package_view.dart';

class EngineeringScreen extends StatelessWidget {
  static const routeName = '/engineering_screen';
  const EngineeringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ইঞ্জিনিয়ারিং"),
        centerTitle: true,
      ),
      body:   const Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(children: [
          Expanded(child: ExamPackageView(category: 'engineering',))
        ],),
      ),
    );
  }
}
