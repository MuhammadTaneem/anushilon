import 'package:flutter/material.dart';

import '../widgets/exam_package_view.dart';

class HscScreen extends StatelessWidget {
  static const routeName = '/hsc_screen';
  const HscScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("এইচ এস সি"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(children: [
          Expanded(child: ExamPackageView(category: 'hsc',))
        ],),
      ),
    );
  }
}
