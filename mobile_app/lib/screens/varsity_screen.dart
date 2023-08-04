import 'package:flutter/material.dart';
import '../widgets/exam_package_view.dart';

class VarsityScreen extends StatelessWidget {
  static const routeName = '/varsity_screen';
  const VarsityScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("ভার্সিটি"),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(children: [
          Expanded(child: ExamPackageView(category: 'varsity',))
        ],),
      ),
    );
  }
}
