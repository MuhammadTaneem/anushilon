import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import 'package:provider/provider.dart';
import '../Providers/favorite_provider.dart';
import '../schema/exam_schema.dart';
import '../screens/home_page_screen.dart';
import '../services/exam_service.dart';
import '../utils/json_formaor.dart';
import '../utils/show_message.dart';
import '../utils/urtils.dart';

class GiveExamWidget extends StatelessWidget {
  final int examId;

  const GiveExamWidget({Key? key, required this.examId}) : super(key: key);

  Future<ExamType> loadExam(int id) async {
    late ExamType _exam;
    try {
      Response response = await getSingleExam(id);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        var aa = jsonDecode(response.body, reviver: reviver);
        _exam = ExamType.fromMap(aa);
        print(_exam);
      } else {
        showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে, পুনঃরায় চেস্টা করুন");
      }
    } catch (error) {
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
          return const Scaffold(
            body: CentralLoading(),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('সাময়িক সমস্যার জন্য দুক্ষিত, পুনঃরায় চেস্টা করুন'),
            ),
          );
        } else {
          ExamType item = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text(item.exam.packageName),
              automaticallyImplyLeading: false,
            ),
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
  late bool confirm = false;


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
              const Gap(10),
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

    return result ??
        false; // Return false if result is null (dialog was dismissed without a choice)
  }

  Future<bool> _showExitWarningDialog(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('সতর্কতা')),
          content: const Text("পরিক্ষা সম্পন্ন করতে সাবমিট বাটনে চাপুন, পরিক্ষা বাহাল রাখতে ওকে বাটন চাপুন "),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("সাবমিট"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('ওকে'),
            ),


          ],
        );
      },
    );

    return result ??
        false; // Return false if result is null (dialog was dismissed without a choice)
  }

  List<Map<String, dynamic>> answeredList=[];
  List showAnswers=[];
  makeFavorite(mcq) {
    Provider.of<FavoriteProvider>(context, listen: false).addItem(mcq);
  }
  removeFavorite(mcqId) {
    Provider.of<FavoriteProvider>(context, listen: false).deleteItem(mcqId);
  }
  ansMcq(mcqId,submittedOption){
    answeredList.add({"mcq":mcqId,"submitted_option":submittedOption});
  }

  _submit() async {
    try{
      final LocalStorage storage = await getStorage();
      Map<String, dynamic> body = {
        "student": await storage.getItem('userId'),
        "exam":widget.exam.id,
        "mcq_submissions":answeredList
      };
      Response response =await submitExam(body);
      if(response.statusCode==201){
        showSuccessMessage(msg: "সফল ভাবে সাবমিট হয়েছে");
        Navigator.pushReplacementNamed(context, HomePageScreen.routeName);
      }
      else{
        print(response.body);
        showErrorMessage(msg: "পরিক্ষা সাবমিট করতে ব্যার্থ হয়েছে, দয়াকরে পুনঃরায় চেস্টা করুন");
    }
    }catch(_){
      showErrorMessage(msg: "সার্ভারে সমস্যার জন্য আন্তরিকভাবে দুক্ষিত");
    }
  }


  _timer(min){
    Timer(Duration(minutes: min), () {
      print('5 minutes done');
      _submit();

    });
  }



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool dialogResult = await _showConfirmationDialog(context);
      if (dialogResult) {
        setState(() {
          confirm = true;
          showAnswers = List<int>.filled(widget.exam.mcqList.length, 0);
          _timer(widget.exam.exam.duration);
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
    return confirm == true?
      WillPopScope(
        onWillPop: () async {
          // Show the warning dialog and wait for the user's decision
          bool exit = await _showExitWarningDialog(context);

          // If the user clicks OK, execute a function (you can replace this with your desired function)
          if (exit) {
            // Your function here
            _submit();

          }

          // Return true to allow the back button press or false to prevent it
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(20),
              // Text('প্যাকেজ: ${widget.exam.exam.packageName}'),
              Text(
                  'সময়: ${banglaNumberFormat.format(widget.exam.exam.duration)} মিনিট'),
              Text(
                  'পরিক্ষা নং: ${banglaNumberFormat.format(widget.exam.exam.examNumber)}'),
              Text(
                  'মার্কস: ${banglaNumberFormat.format(widget.exam.exam.point * widget.exam.exam.noOfQuestion)}'),
              Text('তারিখ: ${dateFormat.format(widget.exam.exam.date)}'),
              const Gap(20),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.exam.mcqList.length,
                separatorBuilder: (BuildContext context, int index) =>
                const Gap(10),
                itemBuilder: (context, index) {
                  return Card(
                    color: showAnswers[index]==0?null:Colors.green.shade100,
                    elevation: 0.8,
                    margin:const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.exam.mcqList[index].imageUrl!.isNotEmpty)
                            // Text("imgUrl${widget.exam.mcqList[index].imageUrl}"),
                            CachedNetworkImage(
                              imageUrl: widget.exam.mcqList[index].imageUrl!,
                              width: double.infinity,
                              height: 200.0,
                              placeholder: (context, url) => SpinKitSpinningLines(
                                color: Theme.of(context).colorScheme.secondary,
                                size: 60.0,
                              ),
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => ErrorWidget(error),
                            ),

                          Text(
                            widget.exam.mcqList[index].question,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                            ),
                          ),

                          ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.exam.mcqList[index].options.length,
                            itemBuilder: (context, optionIndex) {
                              final option = widget.exam.mcqList[index].options[optionIndex];

                              return Row(
                                children: [
                                  Radio(
                                    visualDensity: VisualDensity.compact,
                                    value: showAnswers[index]==optionIndex+1,
                                    groupValue: true,
                                    // onChanged: (value){
                                    //   ansMcq(widget.exam.id,value);
                                    // },
                                    onChanged: showAnswers[index]!=0 ? null:(_) {
                                      ansMcq(widget.exam.mcqList[index].id,optionIndex+1);
                                      setState(() {

                                      showAnswers[index]=optionIndex+1;
                                      });
                                    } ,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (option.text != null) Text(option.text!),
                                        if (option.imageUrl!.isNotEmpty)
                                          CachedNetworkImage(
                                            imageUrl: option.imageUrl!,
                                            width: double.infinity,
                                            height: 100.0,
                                            placeholder: (context, url) =>
                                                SpinKitSpinningLines(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  size: 60.0,
                                                ),
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) =>
                                                ErrorWidget(error),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  widget.exam.mcqList[index].isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.exam.mcqList[index].isFavorite = !widget.exam.mcqList[index].isFavorite;
                                    if (widget.exam.mcqList[index].isFavorite) {
                                      makeFavorite(widget.exam.mcqList[index]);
                                    } else {
                                      removeFavorite(widget.exam.mcqList[index].id);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child:
                    ElevatedButton(
                      onPressed: (){
                        _submit();
                      },
                      child: const Text("Submit"),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ) :  const Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: CentralLoading(),
      );
  }
}
