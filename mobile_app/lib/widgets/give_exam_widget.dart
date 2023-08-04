import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import '../schema/exam_schema.dart';
import '../services/exam_service.dart';
import '../utils/json_formaor.dart';
import '../utils/show_message.dart';

class GiveExamWidget extends StatelessWidget {
  final int examId;

  const GiveExamWidget({Key? key, required this.examId}) : super(key: key);

  Future<ExamType> loadExam(int id) async {
    late ExamType _exam;
    try{
      Response response = await getSingleExam(id);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        var aa =  jsonDecode(response.body, reviver: reviver);
        _exam = ExamType.fromMap(aa);
        print(_exam);
      } else {
        showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে, পুনঃরায় চেস্টা করুন");
      }
    }catch(error){
      print("$error");
      showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে,, পুনঃরায় চেস্টা করুন");
    }

    return _exam;

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExamType>(
      future: loadExam(examId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: const CentralLoading(),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: const Center(
              child: Text('সাময়িক সমস্যার জন্য দুক্ষিত, পুনঃরায় চেস্টা করুন'),
            ),
          );
        } else {
          ExamType item = snapshot.data!;

          return Scaffold(
            appBar: AppBar(title: Text(item.exam.packageName),),
            body: _GiveExamWidgetBody(exam: item),
          );
        }
      },
    );
  }
}

class _GiveExamWidgetBody extends StatefulWidget {
  final ExamType exam;
  const _GiveExamWidgetBody({super.key, required this.exam});

  @override
  State<_GiveExamWidgetBody> createState() => _GiveExamWidgetBodyState();
}

class _GiveExamWidgetBodyState extends State<_GiveExamWidgetBody> {

  late bool confirm =false;
  Future<bool> _showConfirmationDialog(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('সতর্কতা')),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('প্যাকেজ : ${widget.exam.exam.packageName}'),
              Text('পরিক্ষা নং : ${widget.exam.exam.examNumber}'),
              Text('সময়: ${widget.exam.exam.duration} মিনিট'),
              Text('প্রশ্ন সংখা: ${widget.exam.exam.noOfQuestion} টি'),
              const Text('সিলেবাস:'),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.exam.exam.syllabus.map((subject) {
                  return Text('•${subject.subject} : ${subject.chapters}');
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('বাতিল'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('পরিক্ষা শুরু করুন'),
            ),
          ],
        );
      },
    );

    return result ?? false; // Return false if result is null (dialog was dismissed without a choice)
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool dialogResult = await _showConfirmationDialog(context);
      // You can now use the dialogResult variable to change the UI based on the user's choice
      if (dialogResult) {
        setState(() {
        confirm = true;
        });
      } else {
        confirm = false;
        Navigator.of(context).pop();
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.yMMMMd('bn');
    NumberFormat banglaNumberFormat = NumberFormat.decimalPattern('bn');
    return Column(
      children: [
        if (confirm == true)...[
          Column(
            children: [
              // Text('প্যাকেজ: ${widget.exam.exam.packageName}'),
              Text('সময়: ${banglaNumberFormat.format(widget.exam.exam.duration)} মিনিট'),
              Text('পরিক্ষা নং: ${banglaNumberFormat.format(widget.exam.exam.examNumber)}'),
              Text('মার্কস: ${banglaNumberFormat.format(widget.exam.exam.point * widget.exam.exam.noOfQuestion)}'),
              Text('তারিখ: ${dateFormat.format(widget.exam.exam.date)}'),

            ],
          )
        ],
        if(confirm == false)...[
          const Gap(100),
          const CentralLoading()
        ],


      ],
    );
  }
}

