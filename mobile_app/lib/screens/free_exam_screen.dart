import 'package:flutter/material.dart';
import '../widgets/exam_package_view.dart';

class FreeExamScreen extends StatelessWidget {
  static const routeName = '/free_exam_screen';
  const FreeExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ফ্রী পরিক্ষা"),
      ),
      body:   const Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(children: [
          Expanded(child: ExamPackageView(category: 'free_exam',))
        ],),
      ),
    );
  }
}
