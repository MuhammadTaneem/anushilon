import 'package:flutter/material.dart';

class QuestionBankScreen extends StatefulWidget {
  const QuestionBankScreen({Key? key}) : super(key: key);
  static const routeName = '/question_bank_screen';

  @override
  State<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("প্রশ্ন ব্যাংক")),
      body: const Center(
        child: Text("কাজ চলমান...।"),
      ),
    );
  }
}
