import 'package:flutter/cupertino.dart';

class GiveExamScreen extends StatefulWidget {

  final int examId;
  const GiveExamScreen({super.key, required this.examId});

  @override
  State<GiveExamScreen> createState() => _GiveExamScreenState();
}

class _GiveExamScreenState extends State<GiveExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Text("give exam screen is ${widget.examId}");
  }
}
