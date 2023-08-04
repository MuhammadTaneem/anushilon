// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:mobile_app/schema/exam_schema.dart';
// import 'package:mobile_app/utils/show_message.dart';
// import '../services/exam_service.dart';
// import '../utils/json_formaor.dart';
//
// class ExamProvider with ChangeNotifier {
//   late bool _isLoading = false;
//   late  ExamType _exam;
//
//
//
//   Future<void> loadExam(int id) async {
//     try{
//       _isLoading = true;
//       notifyListeners();
//
//       Response response = await getSingleExam(id);
//       print(jsonDecode(response.body));
//       if (response.statusCode == 200) {
//         var aa =  jsonDecode(response.body, reviver: reviver);
//         _exam = ExamType.fromMap(aa);
//         print(_exam);
//       } else {
//         showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে, পুনঃরায় চেস্টা করুন");
//       }
//     }catch(error){
//       print("$error");
//       showErrorMessage(msg: "সার্ভারে সমস্যা হয়েছে,, পুনঃরায় চেস্টা করুন");
//     }
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   ExamType get item{
//     return _exam;
//   }
//
//   bool get isLoading {
//     return _isLoading;
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_app/schema/exam_schema.dart';
import 'package:mobile_app/utils/show_message.dart';
import '../services/exam_service.dart';
import '../utils/json_formaor.dart';

class ExamProvider with ChangeNotifier {
  late bool _isLoading = false;
  late  ExamType _exam;



  Future<void> loadExam(int id) async {
    try{
      _isLoading = true;
      notifyListeners();

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
    _isLoading = false;
    notifyListeners();
  }

  ExamType get item{
    return _exam;
  }

  bool get isLoading {
    return _isLoading;
  }
}
